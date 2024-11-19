import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart'; 
import '../widgets/custom_button.dart';   
import 'registration_screen.dart'; 
import 'home_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Логін'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Відступи навколо
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Центрування елементів
          children: [
            const Text(
              'Ліга Чемпіонів 2024',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CustomTextField(hintText: 'Електронна пошта'), // Використання кастомного поля
            const SizedBox(height: 10),
            const CustomTextField(hintText: 'Пароль', isPassword: true), // Поле пароля
            const SizedBox(height: 20),
            CustomButton(
              text: 'Увійти',
              onPressed: () {
                Navigator.push( // Перехід на головний екран
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push( // Перехід на екран реєстрації
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                );
              },
              child: const Text('Зареєструватися'),
            ),
          ],
        ),
      ),
    );
  }
}
