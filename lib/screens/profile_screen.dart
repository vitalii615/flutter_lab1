import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../storage/user_storage.dart';
import 'profile_edit_screen.dart';
import 'login_screen.dart'; // Не забудьте імпортувати екран входу

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserStorage _userStorage;
  late Future<Map<String, String?>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userStorage = SharedPreferencesUserStorage();
    _userDataFuture = _userStorage.getUserData();
  }

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
        child: FutureBuilder<Map<String, String?>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Показуємо індикатор завантаження
            }

            if (snapshot.hasError) {
              return const Text('Помилка завантаження даних');
            }

            final userData = snapshot.data!;
            final userName = userData['name'] ?? 'Невідоме ім’я';
            final userEmail = userData['email'] ?? 'Невідомий email';

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.15,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: screenWidth * 0.15,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomButton(
                    text: 'Редагувати профіль',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<ProfileEditScreen>(builder: (context) => const ProfileEditScreen()),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomButton(
                    text: 'Вийти',
                    onPressed: _showLogoutDialog,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Вихід з облікового запису'),
          content: const Text('Ви впевнені, що хочете вийти?', style: TextStyle(color: Colors.black),),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Скасувати'),
            ),
            TextButton(
              onPressed: () async {
                await _userStorage.logOut(); // Додаємо await, щоб дочекатися завершення дії
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false, // Забезпечує видалення всіх попередніх маршрутів
                );
              },
              child: const Text('Вийти'),
            ),
          ],
        );
      },
    );
  }
}
