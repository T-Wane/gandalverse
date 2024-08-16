import "package:shared_preferences/shared_preferences.dart";

// ignore: avoid_classes_with_only_static_members
class SharedPreferencesClient {
  static late SharedPreferences _instance;

  // static const String keyName = ""; 
  static const String userCoins_key = "go_userCoins"; 

  static Future<SharedPreferencesClient> init() async {
    _instance = await SharedPreferences.getInstance();
    return SharedPreferencesClient();
  }

  String? getValueForKey({required String key}) => _instance.getString(key);

  Future<void> setValueForKey(
      {required String key, required String value}) async {
    _instance.setString(key, value);
  }

  Future<void> setBooleanForKey(
      {required String key, required bool value}) async {
    _instance.setBool(key, value);
  }

  bool? getBooleanForKey({required String key}) => _instance.getBool(key);

  Future<void> setDoubleForKey(
      {required String key, required double value}) async {
    _instance.setDouble(key, value);
  }

  double? getDoubleForKey({required String key}) => _instance.getDouble(key);

  Future<void> setIntForKey(
      {required String key, required int value}) async {
    _instance.setInt(key, value);
  }

   int? getIntForKey({required String key}) => _instance.getInt(key);


  Future<void> deleteValueForKey({required String key}) async =>
      _instance.remove(key);
}