import 'package:gandalverse/main.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class TelegramClient {
  late TelegramWebApp telegram;

  static Future<TelegramClient> init() async => TelegramClient();

  Future<void> initializeApp() async {
    try {
      if (TelegramWebApp.instance.isSupported) {
        await TelegramWebApp.instance.ready();
        Future.delayed(
            const Duration(seconds: 1), TelegramWebApp.instance.expand);
        telegram = TelegramWebApp.instance;
      }
    } catch (e) {
      print("Error happened in Flutter while loading Telegram $e");
      // add delay for 'Telegram not loading sometimes' bug
      await Future.delayed(const Duration(milliseconds: 200));
      main();
      return;
    }
  }
}
