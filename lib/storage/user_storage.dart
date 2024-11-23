import 'package:shared_preferences/shared_preferences.dart';

abstract class UserStorage {
  Future<void> saveUserData(String name, String surname, String email, String password);
  Future<Map<String, String?>> getUserData();
  Future<void> clearUserData();
  Future<void> updateUserData(Map<String, String> updates);
  Future<bool> isLoggedIn();
  Future<void> logIn();
  Future<void> logOut();
}

class SharedPreferencesUserStorage implements UserStorage {
  static const String _nameKey = 'user_name';
  static const String _surnameKey = 'user_surname';
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';
  static const String _isLoggedInKey = 'is_logged_in';

  @override
  Future<void> saveUserData(String name, String surname, String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_surnameKey, surname);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_isLoggedInKey, true);
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
    await prefs.setBool(_isLoggedInKey, false);
  }

  @override
  Future<void> updateUserData(Map<String, String> updates) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (updates.containsKey('name')) {
      await prefs.setString(_nameKey, updates['name']!);
    }
    if (updates.containsKey('surname')) {
      await prefs.setString(_surnameKey, updates['surname']!);
    }
    if (updates.containsKey('email')) {
      await prefs.setString(_emailKey, updates['email']!);
    }
    if (updates.containsKey('password')) {
      await prefs.setString(_passwordKey, updates['password']!);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().isNotEmpty; 
  }


  @override
  Future<void> logIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true); 
  }

  @override
  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false); 
  }
}
