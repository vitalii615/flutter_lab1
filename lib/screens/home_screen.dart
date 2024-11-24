import 'package:flutter/material.dart';
import 'package:my_project_lab1/utils/network_check.dart'; 
import '../data/matches_data.dart';
import '../widgets/collapsible_tour.dart';
import 'profile_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _openTour = '';

  @override
  void initState() {
    super.initState();
    _checkInternetOnLoad();
  }

  // Перевірка інтернету під час завантаження екрана
  Future<void> _checkInternetOnLoad() async {
    bool isConnected = await NetworkCheck.isConnected();
    if (!isConnected) {
      showNoInternetDialog(
        context,
        'Немає Інтернету',
        'Неможливо користуватися додатком без підключення до інтернету. Підключіть інтернет і натисніть "Refresh".',
      );
    }
  }

  // Перевірка інтернету перед переходом на екран профілю
  Future<void> _navigateToProfileScreen() async {
    bool isConnected = await NetworkCheck.isConnected();
    if (isConnected) {
      Navigator.push<ProfileScreen>(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      showNoInternetDialog(
        context,
        'Немає Інтернету',
        'Підключіть інтернет, щоб продовжити.',
      );
    }
  }

  void _toggleTour(String tourName) {
    setState(() {
      _openTour = (_openTour == tourName) ? '' : tourName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ліга Чемпіонів 2024'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: matchesData.keys.map((tourName) {
                    return CollapsibleTour(
                      tourName: tourName,
                      matches: matchesData[tourName]!,
                      isOpen: _openTour == tourName,
                      onToggle: _toggleTour,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: _navigateToProfileScreen,
              child: const Text('Перейти до профілю'),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
