import 'dart:ui';

import 'package:gandalverse/main.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class TelegramClient {
  late final TelegramWebApp telegram;

  TelegramClient._(this.telegram);

  static Future<TelegramClient> init() async {
    final telegram = await _initializeApp();
    return TelegramClient._(telegram);
  }

  static Future<TelegramWebApp> _initializeApp() async {
    try {
      if (TelegramWebApp.instance.isSupported) {
        await TelegramWebApp.instance.ready();
        await TelegramWebApp.instance.disableVerticalSwipes();
        await TelegramWebApp.instance.expand(); 
        String? startParam = TelegramWebApp.instance.initDataUnsafe?.startParam;
       // String? startParam = TelegramWebApp.instance.initDataUnsafe?.startParam;
        print("startParam $startParam");
        Future.delayed(
          const Duration(seconds: 1),
          TelegramWebApp.instance.expand,
        );
        return TelegramWebApp.instance;
      } else {
        throw Exception('Telegram Web App is not supported.');
      }
    } catch (e) {
      print("Error happened in Flutter while loading Telegram $e");
      // add delay for 'Telegram not loading sometimes' bug
      await Future.delayed(const Duration(milliseconds: 200));
      main();
      rethrow;
    }
  }
}

// class TelegramClient {
//   static late TelegramWebApp telegram;

//   static Future<TelegramClient> init() async {
//     await initializeApp();
//     return TelegramClient();
//   }

//   static Future<void> initializeApp() async {
//     try {
//       if (TelegramWebApp.instance.isSupported) {
//         await TelegramWebApp.instance.ready();
//         Future.delayed(
//             const Duration(seconds: 1), TelegramWebApp.instance.expand);
//         telegram = TelegramWebApp.instance;
//       }
//     } catch (e) {
//       print("Error happened in Flutter while loading Telegram $e");
//       // add delay for 'Telegram not loading sometimes' bug
//       await Future.delayed(const Duration(milliseconds: 200));
//       main();
//       return;
//     }
//   }
// }
