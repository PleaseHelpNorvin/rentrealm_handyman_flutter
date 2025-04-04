import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api/rest.dart';
import '../models/auth_model.dart';

class ApiService {
  final String rest = Rest.baseUrl;
  
  Future<AuthResponse?>postloginHandyMan({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$rest/login');
    print("postloginHandyMan() $uri");
    try {
      // Prepare request body
      final body = {
        "email": email,
        "password": password,
      };

      // Make POST request
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('postloginHandyMan () response.body: ${response.body}');
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('postloginHandyMan() responseData: $responseData');
        return AuthResponse.fromJson(responseData);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exeption: $e');
      return null;
    }
  }
}