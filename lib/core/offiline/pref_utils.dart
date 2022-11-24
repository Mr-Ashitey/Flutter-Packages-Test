import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static bool get isLoggedIn =>
      _sharedPreferences!.getBool("isLoggedIn") ?? false;

  static Future<void> setToken(String token) async =>
      await _sharedPreferences!.setString("token", token);
  static Future<void> setIsLoggedIn() =>
      _sharedPreferences!.setBool("isLoggedIn", true);

  ///will clear all the data stored in preference
  static void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }
}
