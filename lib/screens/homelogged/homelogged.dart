import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home/home.dart'; // Import your HomeScreen
import 'settings/settings.dart'; // Import your SettingScreen

class Homelogged extends StatefulWidget {
  final String token;

  const Homelogged({
    super.key,
    required this.token,
  });

  @override
  State<Homelogged> createState() => _HomeloggedState();
}

class _HomeloggedState extends State<Homelogged> {
  int _currentIndex = 0; // Set to 0 initially since there's only 1 screen

  // List of pages for bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),  // Home screen
    const SettingScreen(),
    // Add other screens here if needed
  ];

  // List of titles for each screen
  final List<String> _titles = [
    'Home',    // Title for HomeScreen
    'Settings', // Title for SettingScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_titles[_currentIndex]), // Dynamic title based on current screen
      ),
      body: _screens[_currentIndex], // Display the screen based on current index
      backgroundColor: const Color(0xFFF6F7FD),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.transparent,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white), // Home icon
          Icon(Icons.settings, size: 30, color: Colors.white), // Settings icon
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the index for navigation
          });
        },
      ),
    );
  }
}
