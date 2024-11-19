import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            foregroundColor: Colors.white, // для тексту і іконок
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
      home: const LoginScreen(),
    );
  }
}
