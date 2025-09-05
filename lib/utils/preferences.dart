import 'package:atfb/export_files/export_files_must.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static saveSharedPref(String key, String value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static Future<String?> getSharedPref(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveSharedPrefBool(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  static Future<bool?> getSharedPrefBool(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  static saveSharedPrefInt(String key, int value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  static Future<int?> getSharedPrefInt(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  static Future<bool?> clearAllPref() async {
    final pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
