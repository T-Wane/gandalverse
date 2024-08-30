import 'package:telegram_web_app/telegram_web_app.dart';
import 'dart:convert';

class TelegramCloudStorage {
  static late TelegramWebApp telegram;

  static Future<TelegramCloudStorage> init() async {
    telegram = TelegramWebApp.instance; 
    telegram.ready();
    return TelegramCloudStorage();
  }

  Future<void> setItem(String key, dynamic value) async {
    final cloudStorage = telegram.cloudStorage;
    await cloudStorage.setItem(key, jsonEncode(value));
  }

  Future<dynamic> getItem(String key) async {
    final cloudStorage = telegram.cloudStorage;
    dynamic storedData;
    await cloudStorage.getItem(
      key,
      (error, [result]) {
        storedData = result;
      },
    );
    return storedData != null ? jsonDecode(storedData) : null;
  }

  Future<void> removeItem(String key) async {
    final cloudStorage = telegram.cloudStorage;
    await cloudStorage.removeItem(key);
  }
}
