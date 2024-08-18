import 'package:flutter/material.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart';
import 'package:injectable/injectable.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'user_repository.dart'; // Le UserRepository doit être défini avec vos méthodes.

@singleton
class TapAndEarnRepository with ChangeNotifier {
  UserProvider _userProvider;
  final TelegramWebApp telegram = TelegramWebApp.instance;

  TapAndEarnRepository(this._userProvider);

  void incrementCoins() {
   
    if (_userProvider.user != null) {
      _userProvider.user!.rebuild((b) => b..coins = (  _userProvider.user?.coins ?? 0) + 1);
      _userProvider
          .updateUser(_userProvider.user!); // Mise à jour de l'utilisateur
      notifyListeners(); // Notifie les listeners pour la mise à jour en temps réel
    }
  }
}
