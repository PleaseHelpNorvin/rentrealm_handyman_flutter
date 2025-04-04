import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  // Simulate logout action (e.g., clearing token, navigating to login screen)
  void _logout() {
    // For now, just show a snackbar (you could add actual logout logic here)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out successfully')),
    );

    // You can use Navigator to navigate to the login screen after logout
    // Example:
    // Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("Settings"),
      // ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text(
              //   "Settings",
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 20),
              // Logout Button
               SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red), // Red background
                  ),
                  onPressed: () {
                    _logout();
                  },
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
