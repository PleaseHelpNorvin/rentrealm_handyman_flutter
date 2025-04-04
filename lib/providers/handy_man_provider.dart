import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rentrealm_handyman_flutter/networks/apiservice.dart';

import '../models/auth_model.dart';
// import '../models/handy_man_model.dart';
import '../models/handy_man_model.dart';
import 'auth_provider.dart';

class HandyManProvider extends ChangeNotifier{
  final ApiService apiService = ApiService();

  late String? token;
  late int? userId;

  Handyman? _handyman;
  Handyman? get handyman => _handyman;
  void setHandyman(Handyman? handyman) {
    _handyman = handyman;
    notifyListeners();
  }

  void _initHandyManDetails(context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    token = authProvider.authData?.token;
    userId = authProvider.user?.id;
  }

  Future<void>fetchHandyMan(BuildContext context) async {
    _initHandyManDetails(context);
    print("from fetchHandyMan() token: $token");
    print("from fetchHandyMan() userId: $userId");
      if (token == null || userId == null) {
        print("no token detected at fetchHandyMan");
        return;
      }

    try {
      final response = await apiService.getHandyMan(token: token);
      if (response != null && response.success) {

        _handyman = response.data.handymans.first;
        notifyListeners();
      } else {
        print("response fails");
      }
    } catch (e) {
      print("EXCEPTION: $e");
      return;
    }
  }



}