import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String jwt = "jwt";
  static final String username = "username";

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(jwt) ?? 'en';
  }

  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(jwt, value);
  }
  static Future<bool> setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(username, value);
  }

    Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('username');
    return stringValue;
  }
}
