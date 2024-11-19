import 'package:flutter/material.dart';
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
              onPressed: () {
                Navigator.push<ProfileScreen>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child: const Text('Перейти до профілю'),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
