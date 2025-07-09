import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveLoginInfo(
    String username,
    String password,
    Map user,
  ) async {
    final prefs = await SharedPreferences.getInstance();


    await prefs.setString('username', username);
    await prefs.setString('user_data', jsonEncode(user));
  }

  static Future<Map<String, dynamic>?> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  static Future<bool> isUserRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    return username != null;
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('user_data');
  }
}
