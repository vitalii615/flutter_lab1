import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'storage/user_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userStorage = SharedPreferencesUserStorage();
  final isLoggedIn = await userStorage.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ліга Чемпіонів 2024',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.indigo[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.black,
          subtitleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
