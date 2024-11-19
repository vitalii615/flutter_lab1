import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart'; 
import '../widgets/custom_button.dart';   

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Реєстрація'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Створіть акаунт',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CustomTextField(hintText: 'Ім’я'),
            const SizedBox(height: 10),
            const CustomTextField(hintText: 'Прізвище'),
            const SizedBox(height: 10),
            const CustomTextField(hintText: 'Електронна пошта'),
            const SizedBox(height: 10),
            const CustomTextField(hintText: 'Пароль', isPassword: true),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Зареєструватися',
              onPressed: () {
                Navigator.pop(context); // Повернення до екрану логіну
              },
            ),
          ],
        ),
      ),
    );
  }
}
