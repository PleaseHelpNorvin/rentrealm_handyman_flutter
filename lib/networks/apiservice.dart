import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../api/rest.dart';
import '../models/auth_model.dart';
import '../models/handy_man_model.dart';
import '../models/maintenance_request_model.dart';

class ApiService {
  final String rest = Rest.baseUrl;

  Future<AuthResponse?> postloginHandyMan({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$rest/login');
    print("postloginHandyMan() $uri");
    try {
      final body = {"email": email, "password": password};

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

  Future<HandyManResponse?> getHandyMan({required String? token}) async {
    print("from getHandyManFetch() token: $token");

    final url = Uri.parse("$rest/handyman/handy_man/index");
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("responseData from getHandyMan() Call: $responseData");
        return HandyManResponse.fromJson(responseData);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print("EXCEPTION $e");
      return null;
    }
  }

  Future<MaintenanceRequestResponse?> getMaintenanceRequest({
    required String? token,
  }) async {
    print("from getMaintenanceRequest() token: $token");

    final url = Uri.parse(
      "$rest/handyman/maintenance_request/get-maintenance-request",
    );
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // print(
        //   "responseData from getMaintenanceRequest() Call: ${jsonEncode(responseData)}",
        // );
        debugPrint(jsonEncode(responseData), wrapWidth: 2048);

        return MaintenanceRequestResponse.fromJson(responseData);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print("EXCEPTION $e");
      return null;
    }
  }
}
