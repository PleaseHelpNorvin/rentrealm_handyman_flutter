import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:rentrealm_handyman_flutter/screens/homelogged/todo/todo_screen.dart';
import 'assigned_maintenance_list/assigned_maintenance.dart';
import 'home/home.dart'; // Import your HomeScreen
import 'history/history.dart';
import 'requested_maintenance_list/requested_maintenance.dart'; // Import your SettingScreen

class Homelogged extends StatefulWidget {
  final String token;

  const Homelogged({super.key, required this.token});

  @override
  State<Homelogged> createState() => _HomeloggedState();
}

class _HomeloggedState extends State<Homelogged> {
  int _currentIndex = 0; // Set to 0 initially since there's only 1 screen

  // List of pages for bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(), // Home screen
    const RequestedMaintenanceScreen(),
    const AssignedMaintenanceScreen(),
    const TodoScreen(),
    const HistoryScreen(),
    // Add other screens here if needed
  ];

  // List of titles for each screen
  final List<String> _titles = [
    'Home', // Title for HomeScreen
    'Requested Maintenance List',
    'Assigned Maintenance List',
    'TodoScreen()',
    'History', // Title for SettingScreen
  ];

  void _logout() {
    print("Icon tapped!");
    // You can perform any action when the icon is tapped, like navigating to another screen
    // Example: Navigator.pushNamed(context, '/anotherScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _titles[_currentIndex],
        ), // Dynamic title based on current screen
        actions: [
          // Tappable IconButton in the AppBar
          IconButton(
            icon: Icon(
              Icons.logout,
            ), // You can replace with any icon you prefer
            onPressed: () {
              _logout();
            }, // Call the function when the icon is tapped
          ),
        ],
      ),
      body:
          _screens[_currentIndex], // Display the screen based on current index
      backgroundColor: const Color(0xFFF6F7FD),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.transparent,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white), // Home icon
          Icon(Icons.request_page, size: 30, color: Colors.white),
          Icon(Icons.assignment, size: 30, color: Colors.white),
          Icon(Icons.today_outlined, size: 30, color: Colors.white),
          Icon(Icons.history, size: 30, color: Colors.white), // Settings icon
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
