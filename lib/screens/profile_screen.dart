import 'package:flutter/material.dart';
import '../widgets/custom_button.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ширина та висота екрану
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профіль'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Центрування
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              CircleAvatar(
                radius: screenWidth * 0.15, // розмір аватарки
                backgroundColor: Colors.grey[300], // фото профілю
                child: Icon(
                  Icons.person,
                  size: screenWidth * 0.15,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Відступ 
              const Text(
                'Ім’я користувача',
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                'email@example.com',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: screenHeight * 0.03), 
              CustomButton(
                text: 'Редагувати профіль',
                onPressed: () {}, // логіка редагування в майб
              ),
              SizedBox(height: screenHeight * 0.02), 
              CustomButton(
                text: 'Вийти',
                onPressed: () {
                  Navigator.pop(context); // Повернення до попереднього екрану
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
