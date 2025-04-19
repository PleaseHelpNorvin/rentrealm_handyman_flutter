import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rentrealm_handyman_flutter/screens/homelogged/homelogged.dart';
import '../models/auth_model.dart';
import '../networks/apiservice.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiSerice = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  User? get user => _user;

  AuthData? _authData;
  AuthData? get authData => _authData;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  // Update AuthData after successful login
  set authData(AuthData? data) {
    _authData = data;
    notifyListeners();
  }

  Future<void> loginHandyMan(
    BuildContext context,
    String email,
    String password,
  ) async {
    print("from loginHandyMan email: $email");
    print("from loginHandyMan password: $password");
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiSerice.postloginHandyMan(
        email: email,
        password: password,
      );
      if (response != null && response.success) {
        _user = response.data.user;
        _authData = response.data; // Update AuthData with response data
        print("Handyman Success login");

        if (_authData == null) {
          print("No token found");
          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => Homelogged(
                  token: _authData!.token, // Pass the token from _authData
                ),
          ),
        );
      } else {
        print("Handyman Failed login");
      }
    } catch (e) {
      print("login Handyman EXCEPTION: $e");
      return;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
