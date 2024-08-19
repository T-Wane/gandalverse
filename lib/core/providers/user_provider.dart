import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/modeles/fields/createUser_fields/createUser_fields.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/repositories/user_repository.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart';
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

  int get telegramUserId =>1016029253;
   // _telegramClient.telegram.initData.user.id;

  UserProvider(
    this._telegramClient,
    this._userRepository,
  ) {
    
    fetchUserByTelegramId();
    notifyListeners();
  }

  Future<void> fetchUserByTelegramId() async {
    _user = await _userRepository.getUserByTelegramId(telegramUserId);
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
    try {
      await _userRepository.updateUser(user);

      _user = user;
      log("########## ${user.toString()}################");
    } catch (e) {
      print("#### error $e");
    }
    notifyListeners();
  }

  Future<void> deleteUser() async {
    if (_user != null) {
      await _userRepository.deleteUser(_user!.id);
      _user = null;
      notifyListeners();
    }
  }

  Future<void> purchaseCard(CarteModel carte, QGService qgService) async {
    await _userRepository.purchaseCard(_user!.id, carte, qgService);
    await reloadServiceData(qgService);
    await fetchUserByTelegramId();
  }

  Future<void> updateCardLevel(
      QGService qgService, CarteModel carteData) async {
    try {
      if (carteData.estAchete == false) {
        await _userRepository.purchaseCard(_user!.id, carteData, qgService);
      } else {
        await _userRepository.updateCardLevel(qgService, _user!.id, carteData);
      }
    } catch (e) {
      print("Error $e");
    }
    await reloadServiceData(qgService);
    await fetchUserByTelegramId();
  }

  Future<void> reloadServiceData(QGService qgService) async {
    // switch (qgService) {
    //   case EquipeService _:
    //     await qgService.loadInitialData();
    //     break;
    //   case PartenaireService _:
    //     await qgService.loadInitialData();
    //     break;
    // }
  }

  Future<List<Map<String, dynamic>>> loadUserPurchasedCards() async {
    if (_user == null) await fetchUserByTelegramId();
    return _userRepository.loadUserPurchasedCards(
      _user?.id ?? '',
    );
  }
}
