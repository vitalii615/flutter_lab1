import 'package:shared_preferences/shared_preferences.dart';

abstract class UserStorage {
  Future<void> saveUserData(String name, String surname, String email, String password);
  Future<Map<String, String?>> getUserData();
  Future<void> clearUserData();
}

class SharedPreferencesUserStorage implements UserStorage {
  static const String _nameKey = 'user_name';
  static const String _surnameKey = 'user_surname';
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';

  @override
  Future<void> saveUserData(String name, String surname, String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_surnameKey, surname);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  @override
  Future<Map<String, String?>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_nameKey),
      'surname': prefs.getString(_surnameKey),
      'email': prefs.getString(_emailKey),
      'password': prefs.getString(_passwordKey),
    };
  }

  @override
  Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_surnameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }
}
