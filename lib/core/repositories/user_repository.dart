import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gandalverse/core/data/levels.dart';
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

  /// Enregistre un utilisateur dans la base de données distante
  ///
  /// Le document est créé avec l'id de l'utilisateur
  ///
  /// Les données de l'utilisateur sont stockées dans un objet JSON
  ///
  /// La méthode est asynchrone
  Future<void> saveUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<UserModel?> getUserByTelegramId(int telegramId) async {
    try {
      // Récupération du document dont l'ID est le telegramId
      final docSnapshot =
          await _firestore.collection('users').doc("$telegramId").get();

      // Vérifie si le document existe
      if (docSnapshot.exists) {
        // Récupère les données du document
        final docData = docSnapshot.data();
        if (docData != null) {
          final user = UserModel.fromJson(docData as Map<String, dynamic>);
          return user;
        }
      }

      // Retourne null si le document n'existe pas ou s'il n'y a pas de données
      return null;
    } catch (e) {
      log('Error getting user: $e');
      return null;
    }
  }

/*
  Future<UserModel?> getUserByTelegramId(int telegramId) async {
    try {
      // Récupération des documents avec le même telegramId
      final querySnapshot = await _firestore
          .collection('users')
          .where('telegramId', isEqualTo: telegramId)
          .get();

//.where('telegramId', isEqualTo: telegramId)
      // Vérifie si la requête renvoie des résultats
      if (querySnapshot.docs.isNotEmpty) {
        // Si plusieurs documents sont trouvés, on supprime les doublons
        if (querySnapshot.docs.length > 1) {
          // Trie les documents par date d'ajout si nécessaire (peut dépendre de ton modèle)
          List<QueryDocumentSnapshot> docs = querySnapshot.docs;

          // Conserve le premier document
          QueryDocumentSnapshot firstDoc = docs.first;

          // Supprime les autres documents en trop
          for (int i = 1; i < docs.length; i++) {
            await _firestore.collection('users').doc(docs[i].id).delete();
          }

          log('Doublons supprimés, seul le premier document est conservé.');
        }

        // Récupère le premier document restant
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
*/
  Future<List<UserModel>> getUserFriends(int telegramId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('parrainId', isEqualTo: '$telegramId')
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
    try {
      if (fields.telegramId != null) {
        // Vérifie si un utilisateur avec ce telegramId existe déjà
        final docSnapshot = await _firestore
            .collection('users')
            .doc("${fields.telegramId}")
            .get();

        // Si l'utilisateur existe déjà, on ne fait rien
        if (docSnapshot.exists) {
          print('Un utilisateur avec cet ID existe déjà.');
          
        } else {
          // Si l'utilisateur n'existe pas, crée un nouveau document
          final user = UserModel((b) => b
            ..id = '${fields.telegramId}'
            ..telegramId = fields.telegramId
            ..firstName = fields.firstName
            ..lastName = fields.lastName
            ..username = fields.username
            ..photoUrl = fields.photoUrl
            ..parrainId = fields.parrainId
            ..level = 1
            ..coins = fields.initialCoin
            ..friends = ListBuilder([])
            ..profitPerHour = 100
            ..profileImage = '');

          await _firestore
              .collection('users')
              .doc("${fields.telegramId}")
              .set(user.toJson());

          // Ajoute cet utilisateur à la liste des amis de son parrain
          addMetoParrainFriends(fields.parrainId, "${fields.telegramId}");
        }
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

/*
  Future<void> createUser({required CreateUserFields fields}) async {
    // final userId = Uuid().v4();
    final user = UserModel((b) => b
      ..id = '${fields.telegramId}'
      ..telegramId = fields.telegramId
      ..firstName = fields.firstName
      ..lastName = fields.lastName
      ..username = fields.username
      ..photoUrl = fields.photoUrl
      ..parrainId = fields.parrainId
      ..level = 1
      ..coins = fields.initialCoin
      ..friends = ListBuilder([])
      ..profitPerHour = 100
      ..profileImage = '');

    try {
      await _firestore
          .collection('users')
          .doc("${fields.telegramId}")
          .set(user.toJson());

      addMetoParrainFriends(fields.parrainId, "${fields.telegramId}");
    } catch (e) {
      print('Error creating user: $e');
    }
  }*/

  void addMetoParrainFriends(String? parrainId, String myId) async {
    if (parrainId == null) return;
    // Référence au document que tu souhaites mettre à jour
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('users').doc(parrainId);

    // Récupération du document pour obtenir la liste actuelle
    DocumentSnapshot snapshot = await documentRef.get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Accès à la list des Firends
      List<Map<String, dynamic>> currentItems = data['friends'] ?? [];

      // Ajouter de nouveaux éléments à la liste existante (si nécessaire)
      Map<String, dynamic> newFriend = {'id': myId, 'reward_isClaimed': false};
      currentItems
          .add(newFriend); // Ajoute les nouveaux éléments à la liste existante

      // Mettre à jour la liste dans Firestore
      await documentRef.update({
        'friends':
            currentItems, // Mettre à jour la liste avec les éléments ajoutés
      });
      print("Liste mise à jour avec succès !");
    } else {
      print("Le document n'existe pas.");
    }
  }

  // Future<void> updateUser(UserModel user) async {
  //   try {
  //     await _firestore.collection('users').doc(user.id).update(user.toJson());
  //   } catch (e) {
  //     print('Error updating user: $e');
  //   }
  // }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  /// Mise à jour du niveau de l'utilisateur en fonction de son nombre de pièces
  ///
  /// On utilise une transaction pour s'assurer que si plusieurs
  /// appels sont faits en même temps, cela ne provoque pas de
  /// problèmes de synchronisation.
  ///
  /// On récupère le document de l'utilisateur, puis on met à jour
  /// son niveau en fonction de son nombre de pièces. Si le niveau
  /// est mis à jour, on enregistre le changement dans le document
  /// de l'utilisateur.
  ///
  /// Si l'utilisateur n'existe pas, on annule la transaction.
  ///
  /// Si une erreur survient, on l'enregistre dans les logs.

  Future<void> updateUserLevel(String userId) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);

      await _firestore.runTransaction((transaction) async {
        final userDoc = await transaction.get(userRef);
        if (!userDoc.exists) {
          log("User does not exist");
          return;
        }

        final userData = userDoc.data() as Map<String, dynamic>;
        final currentLevelIndex = userData['level'];
        final userCoins = userData['coins'];

        final nextLevel = levels.values
            .where((level) => level['index'] > currentLevelIndex)
            .reduce((current, next) =>
                current['index'] < next['index'] ? current : next);

        if (userCoins >= nextLevel['coins_required']) {
          final newLevelIndex = nextLevel['index'];
          transaction.update(userRef, {
            'level': newLevelIndex,
          });
          log('User level updated to $newLevelIndex');
        }
      });
    } catch (e) {
      log('Error updating user level: $e');
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

    qgService.loadingController.add(true);

    bool localpointIsSaved = await userPointIsSaved();
    if (!localpointIsSaved == true) {
      int localPoints = await getPoints();
      await setPointsSaved(true);
      await syncUserCoins(localPoints, userId);
    }

    await _firestore.runTransaction((transaction) async {
      // Récupération du document utilisateur
      DocumentSnapshot userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        log("User does not exist");
        qgService.loadingController.add(false);
        return;
      }

      int userCoins = userDoc['coins'];
      double cardPrice = carte.prix;

      if (userCoins < cardPrice) {
        log("Not enough coins");
        qgService.loadingController.add(false);
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
          'profilParHeure':
              carte.forceNextReelle // passer de 0 à la force n+1 de la carte
          //Raison pour laquelle l'user achete la carte
        });

        // Mise à jour des coins de l'utilisateur
        // incrementer de la différence entre la grade actuelle de la carte et le next grade
        transaction.update(userRef, {
          'coins': userCoins - cardPrice,
          'profitPerHour': userDoc['profitPerHour'] +
              (carte.forceNextReelle - carte.forceReelle)
        });

        // Mise à jour du niveau de l'utilisateur en local
        //ici

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
              ..tauxAugmentationForce = carte.tauxAugmentationForce
              ..contrainteType = carte.contrainteType
              ..valeurContrainte = carte.valeurContrainte));

        isOk = true; // Indique que la transaction a réussi
      } else {
        log("Card already exists in user's collection.");
      }
    });

    // Si la transaction a réussi, on met à jour le service local
    if (isOk) {
      // Récupérer les nouvelles données de l'utilisateur après la transaction
      DocumentSnapshot updatedUserDoc =
          await _firestore.collection('users').doc(userId).get();

      if (updatedUserDoc.exists) {
        // Accéder aux nouvelles données de l'utilisateur
        int updatedCoins = updatedUserDoc['coins'];
        double updatedProfitPerHour = updatedUserDoc['profitPerHour'];
        await updatePoints(updatedCoins);
        await setPointsSaved(true);
      } else {
        log("Failed to retrieve updated user data.");
      }
    }

    qgService.loadingController.add(false);
  }

  Future<void> updateCardLevel(
      QGService qgService, String userId, CarteModel carteData) async {
    DocumentReference userRef = _firestore.collection('users').doc(userId);
    bool isOk = false;
    qgService.loadingController.add(true);

    bool localpointIsSaved = await userPointIsSaved();
    if (!localpointIsSaved == true) {
      int localPoints = await getPoints();
      await setPointsSaved(true);
      await syncUserCoins(localPoints, userId);
    }

    await _firestore.runTransaction((transaction) async {
      // Récupération du document utilisateur
      DocumentSnapshot userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        log("User does not exist");
        qgService.loadingController.add(false);
        return;
      }

      int userCoins = userDoc['coins'];
      double cardPrice = carteData.prixReel;

      if (userCoins < cardPrice) {
        log("Not enough coins");
        qgService.loadingController.add(false);
        return;
      }

      // Référence de la sous-collection "cards" de l'utilisateur
      DocumentReference userCardRef =
          userRef.collection('cards').doc(carteData.carteId);

      // Récupération du document de la carte dans la sous-collection de l'utilisateur
      DocumentSnapshot userCardDoc = await transaction.get(userCardRef);

      // Mise à jour du niveau de la carte et du profil de la carte
      transaction.update(userCardRef, {
        'niveau': carteData.niveau + 1,
        'profilParHeure': carteData
            .forceNextReelle, // Mise à jour du profit avec la nouvelle force
      });

      // Mise à jour des coins et du profit par heure de l'utilisateur
      transaction.update(userRef, {
        'coins': userCoins - cardPrice,
        'profitPerHour': userDoc['profitPerHour'] +
            (carteData.forceNextReelle -
                carteData.forceReelle), // Ajustement du profit
      });
      isOk = true;
      // Mise à jour des données de la carte dans le service local
      await qgService.updateItem(carteData.carteId!, carteData);
    });

    // Si la transaction est réussie, nous mettons à jour la carte en local
    if (isOk) {
      // Récupérer les nouvelles données de l'utilisateur après la transaction
      DocumentSnapshot updatedUserDoc =
          await _firestore.collection('users').doc(userId).get();

      if (updatedUserDoc.exists) {
        // Accéder aux nouvelles données de l'utilisateur
        int updatedCoins = updatedUserDoc['coins'];
        double updatedProfitPerHour = updatedUserDoc['profitPerHour'];
        await updatePoints(updatedCoins);
        await setPointsSaved(true);
      } else {
        log("Failed to retrieve updated user data.");
      }
    }

    qgService.loadingController.add(false);
  }

/*

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
            (carteData.getForce_double)
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
*/

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
      // UserModel user =
      //     UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      // return user;
    });
  }
}
