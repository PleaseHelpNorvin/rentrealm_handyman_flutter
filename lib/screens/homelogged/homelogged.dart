import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../../providers/maintenance_request_provider.dart';
import 'home/home.dart';
import 'requested_maintenance_list/requested_maintenance.dart';
import 'assigned_maintenance_list/assigned_maintenance.dart';
import 'todo/todo_screen.dart';
import 'history/history.dart';

class Homelogged extends StatefulWidget {
  final String token;

  const Homelogged({super.key, required this.token});

  @override
  State<Homelogged> createState() => _HomeloggedState();
}

class _HomeloggedState extends State<Homelogged> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Setting the updateCurrentIndex callback when the widget is initialized
    // Ensures the callback is set when the provider is created
    Provider.of<MaintenanceRequestProvider>(context, listen: false)
        .setUpdateCurrentIndexCallback(updateCurrentIndex);
  }
  // List of pages for bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const RequestedMaintenanceScreen(),
    const AssignedMaintenanceScreen(),
    const TodoScreen(),
    const HistoryScreen(),
  ];

  // List of titles for each screen
  final List<String> _titles = [
    'Home',
    'Requested Maintenance List',
    'Assigned Maintenance List',
    'Todo',
    'History',
  ];

  // Method to update current index for navigation
  void updateCurrentIndex(int index) {

    print("updateCurrentIndex parameter: $index");
    setState(() {
      _currentIndex = index;
    });

    // Print the value that is being received
    print("Current index updated to: $_currentIndex");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MaintenanceRequestProvider(),
      child: Consumer<MaintenanceRequestProvider>(
        builder: (context, maintenanceRequestProvider, child) {
          // Set the callback to update the index when the provider is created
          if (maintenanceRequestProvider.updateCurrentIndexCallback == null) {
            maintenanceRequestProvider.setUpdateCurrentIndexCallback(updateCurrentIndex);
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(_titles[_currentIndex]),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    // _logout();
                  },
                ),
              ],
            ),
            body: _screens[_currentIndex], // Display current screen based on _currentIndex
            backgroundColor: const Color(0xFFF6F7FD),
            bottomNavigationBar: CurvedNavigationBar(
              color: Colors.blue,
              backgroundColor: Colors.transparent,
              items: const <Widget>[
                Icon(Icons.home, size: 30, color: Colors.white),
                Icon(Icons.request_page, size: 30, color: Colors.white),
                Icon(Icons.assignment, size: 30, color: Colors.white),
                Icon(Icons.today_outlined, size: 30, color: Colors.white),
                Icon(Icons.history, size: 30, color: Colors.white),
              ],
              index: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index; // Update the index for navigation
                });
                // Print the value that is being received from the bottom navigation
                print("Tapped index: $index");
              },
            ),
          );
        },
      ),
    );
  }
}
