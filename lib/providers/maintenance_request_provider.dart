import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../../networks/apiservice.dart';
import '../models/auth_model.dart';
import '../models/maintenance_request_model.dart';
import 'handy_man_provider.dart';

class MaintenanceRequestProvider extends ChangeNotifier{
  final ApiService apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late String? token;
  late int? userId;
  late int? handymanId;

  List<MaintenanceRequest?> _maintenanceRequestList = [];
  List<MaintenanceRequest?> get maintenanceRequestList => _maintenanceRequestList;
  
  List<MaintenanceRequest?> get pendingRequests {
    return _maintenanceRequestList.where((request) => request?.status == 'pending').toList();
  }

  void addMaintenanceRequest(MaintenanceRequest request) {
    _maintenanceRequestList.add(request);
    notifyListeners();
  }

  void removeMaintenanceRequest(MaintenanceRequest request) {
    _maintenanceRequestList.remove(request);
    notifyListeners();
  }
//note: no need for update setter because once the status changed to assigned: it will be removed to the list automatically

  void _initMaintenanceRequestDetails(context) {
    final handymanProvider = Provider.of<HandyManProvider>(context, listen:  false);
    token = handymanProvider.token;
    userId = handymanProvider.userId;
    handymanId = handymanProvider.handyman?.id;
  }

  Future<void>fetchMaintenanceRequest(BuildContext context) async {
    _initMaintenanceRequestDetails(context);

    print("from fetchMaintenanceRequest() token: $token");
    print("from fetchMaintenanceRequest() userId: $userId");
    print("from fetchMaintenanceRequest() handymanId: $handymanId");

    if (token == null || userId == null) {
      print("no token detected at fetchHandyMan");
      return;
    }

    try {
       final response = await apiService.getMaintenanceRequest(token: token);

       if(response != null && response.success) {
        print("success");
        _maintenanceRequestList = response.data.maintenanceRequests;
        notifyListeners();
       }else {
        print("failed");
       }
    } catch (e) {
      print("EXCEPTION: $e");
      return;
    }
  }

}