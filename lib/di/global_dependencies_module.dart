import 'package:gandalverse/data/firebase_client.dart';
import 'package:gandalverse/data/shared_preferences/shared_preferences_client.dart';
import 'package:gandalverse/data/telegram_client.dart';
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart';
import 'package:injectable/injectable.dart' hide Environment;

@module
abstract class GlobalDependenciesModule {
  @preResolve
  Future<SharedPreferencesClient> get sharedPreferenceClient =>
      SharedPreferencesClient.init();

  @preResolve
  Future<TelegramCloudStorage> get telegramStorage =>
      TelegramCloudStorage.init();

  // @preResolve
  // Future<TelegramClient> get telegramClient => TelegramClient.init();

  @preResolve
  Future<FirebaseClient> get firebaseClient => FirebaseClient.init();
}
