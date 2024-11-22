import 'package:flutter/material.dart';
import '../storage/user_storage.dart';
import 'login_screen.dart'; // Перехід на екран логіну після редагування

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late UserStorage _userStorage;

  @override
  void initState() {
    super.initState();
    _userStorage = SharedPreferencesUserStorage();
  }

  // Валідація email
  String? _validateEmail(String? value) {
    final emailExp = RegExp(r'^[a-z]{1}[a-z]*\.[a-z]{1}[a-z]*@[a-z]+\.[a-z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Електронна пошта обов’язкова для заповнення.';
    } else if (!emailExp.hasMatch(value)) {
      return 'Формат ел. пошти має бути firstinitial.lastname@domain.com';
    }
    return null;
  }

  // Валідація паролю
  String? _validatePassword(String? value) {
    final passwordExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Пароль обов’язковий для заповнення.';
    } else if (!passwordExp.hasMatch(value)) {
      return 'Пароль має бути не менше 8 символів, містити велику літеру, малу літеру, цифру і спеціальний символ.';
    }
    return null;
  }

  // Діалог для помилки валідації
  void _showDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Не вдалося модифікувати дані',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'Перевірте наступні вимоги:\n\n'
            '1. Електронна пошта повинна бути у форматі firstinitial.lastname@domain.com.\n'
            '2. Пароль повинен містити не менше 8 символів, включаючи велику літеру, малу літеру, цифру і спеціальний символ.',
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

  // Відправка форми та оновлення даних
  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Отримуємо нові значення з полів форми
      final updatedData = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      // Оновлюємо дані користувача
      await _userStorage.updateUserData(updatedData);

      // Якщо зміна була успішною, переходимо на екран логіну
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      // Якщо дані не проходять перевірку, показуємо діалог
      _showDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редагувати профіль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Електронна пошта'),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Пароль'),
                validator: _validatePassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Зберегти зміни'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
