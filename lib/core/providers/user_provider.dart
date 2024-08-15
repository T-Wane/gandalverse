import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

@singleton
class UserProvider extends ChangeNotifier {
  UserRepository _userRepository;

  UserModel? _user;

  UserModel? get user => _user;

  UserProvider(this._userRepository) { 
    notifyListeners();
  }

  Future<void> fetchUserByTelegramId(int telegramId) async {
    _user = await _userRepository.getUserByTelegramId(telegramId);
    notifyListeners();
  }

  Future<void> createUser(int telegramId, String firstName, String lastName,
      String username, String photoUrl) async {
    await _userRepository.createUser(
      telegramId: telegramId,
      firstName: firstName,
      lastName: lastName,
      username: username,
      photoUrl: photoUrl,
    );
    await fetchUserByTelegramId(telegramId);
  }

  Future<void> updateUser(UserModel user) async {
    await _userRepository.updateUser(user);
    _user = user;
    notifyListeners();
  }

  Future<void> deleteUser() async {
    if (_user != null) {
      await _userRepository.deleteUser(_user!.id);
      _user = null;
      notifyListeners();
    }
  }
}
