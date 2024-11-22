import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart'; 
import '../widgets/custom_button.dart';   
import '../storage/user_storage.dart'; 
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserStorage _userStorage;

  @override
  void initState() {
    super.initState();
    _userStorage = SharedPreferencesUserStorage();
  }

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
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
        title: const Text('Реєстрація'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Form(
          key: _formKey,
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
              SizedBox(height: screenHeight * 0.03), // Відступ
              CustomTextField(
                hintText: 'Ім’я',
                controller: _nameController,
                validator: _validateName,
              ),
              SizedBox(height: screenHeight * 0.015), // Відступ між полями
              CustomTextField(
                hintText: 'Прізвище',
                controller: _surnameController,
                validator: _validateSurname,
              ),
              SizedBox(height: screenHeight * 0.015),
              CustomTextField(
                hintText: 'Електронна пошта',
                controller: _emailController,
                validator: _validateEmail,
              ),
              SizedBox(height: screenHeight * 0.015),
              CustomTextField(
                hintText: 'Пароль',
                isPassword: true,
                controller: _passwordController,
                validator: _validatePassword,
              ),
              SizedBox(height: screenHeight * 0.03), // Відступ перед кнопкою
              CustomButton(
                text: 'Зареєструватися',
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      await _userStorage.saveUserData(
        _nameController.text,
        _surnameController.text,
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(builder: (context) => const LoginScreen()),
      );
    } else {
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Регістрація фейл',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'Перевірте наступні вимоги:\n\n'
            '1. Ім’я повинно містити лише букви англійського або українського алфавіту.\n'
            '2. Прізвище повинно містити лише букви англійського або українського алфавіту.\n'
            '3. Електронна пошта повинна бути у форматі firstinitial.lastname@domain.com.\n'
            '4. Пароль повинен містити не менше 8 символів, включаючи велику літеру, малу літеру, цифру і спеціальний символ.',
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

  String? _validateName(String? value) {
    final nameExp = RegExp(r'^[A-Za-zА-Яа-я]+$');
    if (value == null || value.isEmpty) {
      return 'Ім’я обов’язкове для заповнення.';
    } else if (!nameExp.hasMatch(value)) {
      return 'Ім’я має містити лише букви алфавіту.';
    }
    return null;
  }

  String? _validateSurname(String? value) {
    final surnameExp = RegExp(r'^[A-Za-zА-Яа-я]+$');
    if (value == null || value.isEmpty) {
      return 'Прізвище обов’язкове для заповнення.';
    } else if (!surnameExp.hasMatch(value)) {
      return 'Прізвище має містити лише букви алфавіту.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final emailExp = RegExp(r'^[a-z]{1}[a-z]*\.[a-z]{1}[a-z]*@[a-z]+\.[a-z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Електронна пошта обов’язкова для заповнення.';
    } else if (!emailExp.hasMatch(value)) {
      return 'Формат ел. пошти має бути firstinitial.lastname@domain.com';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final passwordExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Пароль обов’язковий для заповнення.';
    } else if (!passwordExp.hasMatch(value)) {
      return 'Пароль має бути не менше 8 символів, містити велику літеру, малу літеру, цифру і спеціальний символ.';
    }
    return null;
  }
}
