import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/modeles/fields/createUser_fields/createUser_fields.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TelegramCloudStorage _telegramCloudStorage;
  String userPointKey = "ggv_user_point";
  String userPointIsSaveKey = "ggv_user_pointIsSaved";

  UserRepository(this._telegramCloudStorage);

  Future<UserModel?> getUserByTelegramId(int telegramId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('telegramId', isEqualTo: telegramId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first.data();
        final user = UserModel.fromJson(doc as Map<String, dynamic>);
        return user;
      }
      return null;
    } catch (e) {
      log('Error getting user: $e');
      return null;
    }
  }

  Future<List<UserModel>> getUserFriends(int telegramId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('parrainId', isEqualTo: telegramId)
          .get();

      print('getUserFriends => querySnapshot : ${querySnapshot.docs.length}');
      if (querySnapshot.docs.isNotEmpty) {
        // Mappez chaque document à un objet UserModel
        final users = querySnapshot.docs.map((doc) {
          print('getUserFriends =>: $doc');
          return UserModel.fromJson(doc.data());
        }).toList();
        return users;
      }
      return []; // Retourne une liste vide si aucun utilisateur n'est trouvé
    } catch (e) {
      print('Error getting user friends: $e');
      return []; // Retourne une liste vide en cas d'erreur
    }
  }

  Future<List<Map<String, dynamic>>> loadUserPurchasedCards(
      String userId) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(userId);

      // Accès à la collection des cartes achetées par l'utilisateur
      QuerySnapshot snapshot = await userRef.collection('cards').get();

      // Convertir les documents en objets CarteModel
      List<Map<String, dynamic>> cards = snapshot.docs.map((doc) {
        return doc.data() as Map<String,
            dynamic>; //CarteModel.fromJson(doc as Map<String, dynamic>);
      }).toList();

      return cards;
    } catch (e) {
      log("Erreur lors du chargement des cartes : $e");
      return [];
    }
  }

  Future<void> createUser({required CreateUserFields fields}) async {
    final userId = Uuid().v4();
    final user = UserModel((b) => b
      ..id = userId
      ..telegramId = fields.telegramId
      ..firstName = fields.firstName
      ..lastName = fields.lastName
      ..username = fields.username
      ..photoUrl = fields.photoUrl
      ..level = 1
      ..coins = 2500
      ..profitPerHour = 5.0
      ..profileImage = '');

    try {
      await _firestore.collection('users').doc(userId).set(user.toJson());
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toJson());
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  //-----------------------------------------//
  Future<void> updatePoints(int newPoints) async {
    //  await  _telegramCloudStorage.setItem(userPointKey, newPoints);
    //   await _telegramCloudStorage.setItem(userPointIsSaveKey, false);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(userPointKey, newPoints);
    await prefs.setBool(userPointIsSaveKey, false);
  }

  Future<void> setPointsSaved(bool status) async {
    // _telegramCloudStorage.setItem(userPointIsSaveKey, status);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(userPointIsSaveKey, status);
  }

  Future<int> getPoints() async {
    // int userPoint = await _telegramCloudStorage.getItem(userPointKey);
    final prefs = await SharedPreferences.getInstance();
    int? userPoint = prefs.getInt(userPointKey);
    return userPoint ?? 0;
  }

  Future<bool> userPointIsSaved() async {
    // bool isSaved = await _telegramCloudStorage.getItem(userPointIsSaveKey);
    final prefs = await SharedPreferences.getInstance();
    bool? isSaved = prefs.getBool(userPointIsSaveKey);
    return isSaved ?? true;
  }

  //------------------------------//
  Future<void> purchaseCard(
      String userId, CarteModel carte, QGService qgService) async {
    DocumentReference userRef = _firestore.collection('users').doc(userId);
    bool isOk = false;

    await _firestore.runTransaction((transaction) async {
      // Récupération du document utilisateur
      DocumentSnapshot userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        log("User does not exist");
        return;
      }

      int userCoins = userDoc['coins'];
      double cardPrice = carte.prix;

      if (userCoins < cardPrice) {
        log("Not enough coins");
        return;
      }

      // Référence de la sous-collection "cards" de l'utilisateur
      DocumentReference userCardRef =
          userRef.collection('cards').doc(carte.carteId);

      // Récupération du document de la carte dans la sous-collection de l'utilisateur
      DocumentSnapshot userCardDoc = await transaction.get(userCardRef);

      if (!userCardDoc.exists) {
        // Si la carte n'existe pas dans la sous-collection, on la crée
        transaction.set(userCardRef, {
          'id': carte.carteId,
          'nom': carte.nom,
          'categorie_carte':
              (qgService is EquipeService) ? "Equipe Card" : "Paternaire Card",
          'niveau': 1,
          'est_achete': true,
          'profilParHeure': carte.force * carte.tauxAugmentationForce,
        });

        // Mise à jour des coins de l'utilisateur
        transaction.update(userRef, {
          'coins': userCoins - cardPrice,
          'profitPerHour': userDoc['profitPerHour'] +
              (carte.force * carte.tauxAugmentationForce)
        });

        //if (qgService is EquipeService) {
        await qgService.updateItem(
            carte.carteId!,
            CarteModel((b) => b
              ..carteId = carte.carteId
              ..nom = carte.nom
              ..description = carte.description
              ..competences =
                  BuiltList<String>.from(carte.competences?.toList() ?? [])
                      .toBuilder()
              ..image = carte.image
              ..prix = carte.prix
              ..tauxAugmentation = carte.tauxAugmentation
              ..niveau = 1
              ..estAchete = true
              ..force = carte.force
              ..tauxAugmentationForce = carte.tauxAugmentationForce));

        isOk = true; // Indique que la transaction a réussi
      } else {
        log("Card already exists in user's collection.");
      }
    });

    // Si la transaction a réussi, on met à jour le service local
    if (isOk) {}
  }

  Future<void> updateCardLevel(
      QGService qgService, String userId, CarteModel carteData) async {
    DocumentReference userRef = _firestore.collection('users').doc(userId);
    bool isOk = false;

    await _firestore.runTransaction((transaction) async {
      // Récupération du document utilisateur
      DocumentSnapshot userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        log("User does not exist");
        return;
      }

      int userCoins = userDoc['coins'];
      double cardPrice = carteData.getPrix_inDouble;

      if (userCoins < cardPrice) {
        log("Not enough coins");
        return;
      }

      // Référence de la sous-collection "cards" de l'utilisateur
      DocumentReference userCardRef =
          userRef.collection('cards').doc(carteData.carteId);

      // Récupération du document de la carte dans la sous-collection de l'utilisateur
      DocumentSnapshot userCardDoc = await transaction.get(userCardRef);

      transaction.update(userCardRef, {
        'niveau': carteData.niveau,
        'profilParHeure': carteData.force * carteData.tauxAugmentationForce,
      });
      // Mise à jour des coins de l'utilisateur
      transaction.update(userRef, {
        'coins': userCoins - cardPrice,
        'profitPerHour': userDoc['profitPerHour'] +
            (carteData.force * carteData.tauxAugmentationForce)
      });
      await qgService.updateItem(carteData.carteId!, carteData);
    });

    // await _firestore
    //     .collection('users')
    //     .doc(userId)
    //     .collection('cards')
    //     .doc(carteData.carteId)
    //     .update({
    //   'niveau': carteData.niveau,
    //   'profilParHeure': carteData.force * carteData.tauxAugmentationForce,
    // }).whenComplete(() async {
    //   await qgService.updateItem(carteData.carteId!, carteData);
    // });
  }

  Future<UserModel?> syncUserCoins(int localCoins, String _userId) async {
    DocumentReference userRef = _firestore.collection('users').doc(_userId);

    await _firestore.runTransaction((transaction) async {
      // Récupération du document utilisateur
      DocumentSnapshot userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        log("User does not exist");
        return null;
      }

      // Mise à jour des coins de l'utilisateur
      transaction.update(userRef, {'coins': localCoins});
      setPointsSaved(true);
      UserModel user =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      return user;
    });
  }
}
