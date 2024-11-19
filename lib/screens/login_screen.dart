import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart'; 
import '../widgets/custom_button.dart';   
import 'registration_screen.dart'; 
import 'home_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Логін'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Відступи
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Text(
              'Ліга Чемпіонів 2024',
              style: TextStyle(
                fontSize: screenWidth * 0.06, 
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // Висота відступу
            const CustomTextField(hintText: 'Електронна пошта'),
            SizedBox(height: screenHeight * 0.015), 
            const CustomTextField(hintText: 'Пароль', isPassword: true),
            SizedBox(height: screenHeight * 0.03), // Відступ перед кнопкою
            CustomButton(
              text: 'Увійти',
              onPressed: () {
                Navigator.push<HomeScreen>(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.02), // Відступ між кнопками
            TextButton(
              onPressed: () {
                Navigator.push<RegistrationScreen>(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                );
              },
              child: Text(
                'Зареєструватися',
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
