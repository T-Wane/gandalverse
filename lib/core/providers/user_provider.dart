import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/fields/createUser_fields/createUser_fields.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/repositories/user_repository.dart';
import 'package:gandalverse/data/telegram_client.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

@singleton
class UserProvider extends ChangeNotifier {
  UserRepository _userRepository;
  TelegramClient _telegramClient;

  UserModel? _user;

  UserModel? get user => _user;

  int get telegramUserId => _telegramClient.telegram.initData.user.id;

  UserProvider( this._telegramClient,this._userRepository,) {
    fetchUserByTelegramId();
    notifyListeners();
  }

  Future<void> fetchUserByTelegramId() async {
    _user = await _userRepository
        .getUserByTelegramId(_telegramClient.telegram.initData.user.id);
    if (user == null) {
      TelegramUser user = _telegramClient.telegram.initData.user;
      createUser(
        telegramId: _telegramClient.telegram.initData.user.id,
        firstName: user.firstname,
        lastName: user.lastname,
        username: user.username,
        photoUrl: _telegramClient.telegram.initDataUnsafe?.user?.photoUrl,
      );
    }
    notifyListeners();
  }

  Future<void> createUser(
      {required int telegramId,
      String? firstName,
      String? lastName,
      String? username,
      String? photoUrl}) async {
    CreateUserFields fields = CreateUserFields(
        telegramId: telegramId,
        firstName: firstName,
        lastName: lastName,
        username: username,
        photoUrl: photoUrl);
    await _userRepository.createUser(fields: fields);
    await fetchUserByTelegramId();
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
