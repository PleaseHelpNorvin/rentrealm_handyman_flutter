import 'dart:async';
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

  Future<HandyManResponse?> getHandyMan({
    required String? token,
    required int? userId,
  }) async {
    print("from getHandyman() token: $token");
    print("from getHandyman() userId: $userId");

    final url = Uri.parse(
      "$rest/handyman/handy_man/show-handyman-by-user-id/$userId",
    );
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      print("uri: $url");
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("responseData from getHandyman() Call: $responseData");
        return HandyManResponse.fromJson(responseData);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print("getHandyMan EXCEPTION $e");
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

      print("RAW BODY LENGTH: ${response.body.length}");
      print("RAW RESPONSE BODY:\n${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if the response body is not null and is not empty
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          print(
            "-------------------------------------------------------------------------------------",
          );
          debugPrint(
            "getMaintenanceRequest Decoded JSON:\n${jsonEncode(responseData)}",
            wrapWidth: 4096,
          );
          print(
            "-------------------------------------------------------------------------------------",
          );

          return MaintenanceRequestResponse.fromJson(responseData);
        } else {
          print("Error: Empty response body");
          return null;
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print("getMaintenanceRequest EXCEPTION $e");
      return null;
    }
  }

  Future<MaintenanceRequestResponse?> patchMaintenanceRequestToStatusRequest({
    required String? token,
    required int maintenanceRequestId,
    required int? handymanId,
  }) async {
    print('from patchMaintenanceRequestToStatusRequest() token: $token');
    print(
      'from patchMaintenanceRequestToStatusRequest() maintenanceRequestId: $maintenanceRequestId',
    );
    print(
      'from patchMaintenanceRequestToStatusRequest() handymanId: $handymanId',
    );

    final url = Uri.parse(
      "$rest/handyman/maintenance_request/patch-maintenance-request-to-requested/$maintenanceRequestId/$handymanId",
    );
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      print("url: $url");
      final response = await http.patch(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(
          "responseData from patchMaintenanceRequestToStatusRequest() Call: ${jsonEncode(responseData)}",
        );
        // debugPrint(jsonEncode(responseData), wrapWidth: 2048);

        return MaintenanceRequestResponse.fromJson(responseData);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print("patchMaintenanceRequestToStatusRequest EXCEPTION: $e");
      return null;
    }
  }

  Future<MaintenanceRequestResponse?>
  patchMaintenanceRequestToStatusInProgress({
    required String? token,
    required int maintenanceRequestId,
  }) async {
    print('from patchMaintenanceRequestToStatusInProgress() token: $token');
    print(
      'from patchMaintenanceRequestToStatusInProgress() maintenanceRequestId: $maintenanceRequestId',
    );

    final url = Uri.parse(
      "$rest/handyman/maintenance_request/patch-maintenance-request-to-in-progress/$maintenanceRequestId",
    );
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      print("url: $url");
      final response = await http.patch(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(
          "responseData from patchMaintenanceRequestToStatusInProgress() Call: ${jsonEncode(responseData)}",
        );
        // debugPrint(jsonEncode(responseData), wrapWidth: 2048);

        return MaintenanceRequestResponse.fromJson(responseData);
      } else {
        // final Map<String, dynamic> responseData = jsonDecode(response.body);
        // final errorMessage = responseData['message'] ?? 'Something went wrong';
        // print('Error: ${response.statusCode} - $errorMessage');
        // return errorMessage;
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print("patchMaintenanceRequestToStatusInProgress EXCEPTION: $e");
      return null;
    }
  }

  Future<MaintenanceRequestResponse?> patchMaintenanceRequestToForApprove({
    required String? token,
    required int maintenanceRequestId,
  }) async {
    print('from patchMaintenanceRequestToStatusComplete() token: $token');
    print(
      'from patchMaintenanceRequestToStatusComplete() maintenanceRequestId: $maintenanceRequestId',
    );

    final url = Uri.parse(
      "$rest/handyman/maintenance_request/patch-maintenance-request-to-for-approve/$maintenanceRequestId",
    );

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await http.patch(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // print(
        //   "responseData from patchMaintenanceRequestToStatusComplete() Call: ${jsonEncode(responseData)}",
        // );
        print(
          "-------------------------------------------------------------------------------------",
        );
        debugPrint(jsonEncode(responseData), wrapWidth: 4096);
        print(
          "-------------------------------------------------------------------------------------",
        );

        return MaintenanceRequestResponse.fromJson(responseData);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print("patchMaintenanceRequestToForApprove EXCEPTION: $e");
      return null;
    }
  }
}
