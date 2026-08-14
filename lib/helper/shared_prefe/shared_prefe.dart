import 'package:shared_preferences/shared_preferences.dart';

class SharePrefHelper {
  static Future<bool> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<bool> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
