import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../storage/user_storage.dart';
import 'profile_edit_screen.dart';

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
                        MaterialPageRoute<ProfileEditScreen>(builder: (context) => ProfileEditScreen()),
                      ); // Виправлення: додано закриття дужок
                    },
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
            );
          },
        ),
      ),
    );
  }
}
