import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart'; 
import '../widgets/custom_button.dart';   

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Отримання розмірів екрана
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Реєстрація'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Створіть акаунт',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // відступ
            const CustomTextField(hintText: 'Ім’я'),
            SizedBox(height: screenHeight * 0.015), // між текстовими полями
            const CustomTextField(hintText: 'Прізвище'),
            SizedBox(height: screenHeight * 0.015),
            const CustomTextField(hintText: 'Електронна пошта'),
            SizedBox(height: screenHeight * 0.015),
            const CustomTextField(hintText: 'Пароль', isPassword: true),
            SizedBox(height: screenHeight * 0.03), // перед кнопкою
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
