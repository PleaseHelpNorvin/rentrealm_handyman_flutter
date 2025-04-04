
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rentrealm_handyman_flutter/providers/handy_man_provider.dart';

import 'providers/auth_provider.dart';
import 'providers/maintenance_request_provider.dart';
import 'screens/auth/login.dart';
import 'screens/get_started.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
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
    return MultiProvider (
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
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue
              ),
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
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              //for 50% width for button 
                // FractionallySizedBox(
                //   widthFactor: 0.5, // 50% width
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: Text('Half Width'),
                //   ),
                // ),

              // for double.infinity elevatedButton
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: Text('Full Width'),
                //   ),
                // ),

            ),
            darkTheme: ThemeData.dark(),
            home: const GetStartedScreen(),
            routes: {
              '/get_started' : (context) => GetStartedScreen(),
              '/login': (context) => LoginScreen(),
            },


          );
        } 
      ),
    );
  }
}

