import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gandalverse/core/modeles/fields/createUser_fields/createUser_fields.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
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
}
