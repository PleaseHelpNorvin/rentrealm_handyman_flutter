import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rentrealm_handyman_flutter/providers/handy_man_provider.dart';

import 'providers/auth_provider.dart';
import 'providers/maintenance_request_provider.dart';
import 'screens/auth/login.dart';
import 'screens/get_started.dart';
import 'screens/homelogged/assigned_maintenance_list/assigned_maintenance.dart';
import 'screens/homelogged/history/history.dart';
import 'screens/homelogged/home/home.dart';
import 'screens/homelogged/requested_maintenance_list/requested_maintenance.dart';
import 'screens/homelogged/todo/todo_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HandyManProvider()),
        ChangeNotifierProvider(create: (_) => MaintenanceRequestProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Rent Realm: HandyMan',
            theme: ThemeData(
              scaffoldBackgroundColor:
                  Colors.white, // or any other color you prefer
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue, // sets AppBar background color
                foregroundColor: Colors.white, // sets text & icon color
                elevation: 0,
                centerTitle: false,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // darkTheme: ThemeData.dark(),
            home: const GetStartedScreen(),
            routes: {
              '/get_started': (context) => GetStartedScreen(),
              '/login': (context) => LoginScreen(),
              '/home': (context) => const HomeScreen(),
              '/requestedMaintenance':
                  (context) => const RequestedMaintenanceScreen(),
              '/assignedMaintenance':
                  (context) => const AssignedMaintenanceScreen(),
              '/todo': (context) => const TodoScreen(),
              '/history': (context) => const HistoryScreen(),
            },
          );
        },
      ),
    );
  }
}
