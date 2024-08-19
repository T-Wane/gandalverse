import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/modeles/fields/createUser_fields/createUser_fields.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';
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
      print('Error getting user: $e');
      return null;
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
    DocumentReference cardRef =
        _firestore.collection('cards').doc(carte.carteId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot userDoc = await transaction.get(userRef);
      DocumentSnapshot cardDoc = await transaction.get(cardRef);

      if (!userDoc.exists || !cardDoc.exists) {
        throw Exception("User or Card does not exist");
      }

      int userCoins = userDoc['coins'];
      double cardPrice = cardDoc['prix'];

      if (userCoins < cardPrice) {
        throw Exception("Not enough coins");
      }

      // Update user's coins
      transaction.update(userRef, {
        'coins': userCoins - cardPrice,
      });

      // Add card to user's collection if not already present
      transaction.set(userRef.collection('cards').doc(carte.carteId), {
        'id': carte.carteId,
        'niveau': 1,
        'est_achete': true,
        'profilParHeure': cardDoc['force'] * cardDoc['tauxAugmentationForce'],
      });

      qgService.updateItem(
          carte.carteId!,
          CarteModel((b) => b
            ..nom = carte.nom
            ..description = carte.description
            ..competences =
                BuiltList<String>.from(carte.competences?.toList() ?? [])
                    .toBuilder()
            ..image = carte.image
            ..prix = carte.prix
            ..tauxAugmentation = carte.tauxAugmentation
            ..niveau = carte.niveau + 1
            ..estAchete = carte.estAchete
            ..force = carte.force
            ..tauxAugmentationForce = carte.tauxAugmentationForce));
    });
  }

  Future<void> updateCardLevel(
      QGService qgService, String userId, CarteModel carteData
      // String cardId, int newLevel,
      //   double newProfilParHeure
      ) async {
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
