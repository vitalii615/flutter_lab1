import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart'; 
import '../widgets/custom_button.dart';   
import 'registration_screen.dart'; 
import 'home_screen.dart'; 
import '../storage/user_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserStorage _userStorage;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userStorage = SharedPreferencesUserStorage();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
        child: Form(
          key: _formKey,
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
              CustomTextField(
                hintText: 'Електронна пошта',
                controller: _emailController,
              ),
              SizedBox(height: screenHeight * 0.015), 
              CustomTextField(
                hintText: 'Пароль',
                isPassword: true,
                controller: _passwordController,
              ),
              SizedBox(height: screenHeight * 0.03), // Відступ перед кнопкою
              CustomButton(
                text: 'Увійти',
                onPressed: () async {
                  final userData = await _userStorage.getUserData();
                  if (_emailController.text == userData['email'] && _passwordController.text == userData['password']) {
                    await _userStorage.logIn();
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(builder: (context) => const HomeScreen()),
                    );
                  } else {
                    _showLoginErrorDialog();
                  }
                },
              ),
              SizedBox(height: screenHeight * 0.02), // Відступ між кнопками
              TextButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(builder: (context) => const RegistrationScreen()),
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
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  void _showLoginErrorDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Помилка входу',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'Невірна електронна пошта або пароль. Будь ласка, спробуйте ще раз.',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Зрозуміло'),
            ),
          ],
        );
      },
    );
  }
}
