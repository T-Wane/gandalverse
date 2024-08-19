import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/modeles/fields/createUser_fields/createUser_fields.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart';
import 'package:uuid/uuid.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TelegramCloudStorage _telegramCloudStorage;

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
      ..coins = 0
      ..profitPerHour = 0.0
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

  // Future<void> updatePoints(UserModel user, int newPoints) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_pointsKey, newPoints);
  // }
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
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cards')
        .doc(carteData.carteId)
        .update({
      'niveau': carteData.niveau,
      'profilParHeure': carteData.force * carteData.tauxAugmentationForce,
    }).whenComplete(() async {
      await qgService.updateItem(carteData.carteId!, carteData);
    });
  }
}
