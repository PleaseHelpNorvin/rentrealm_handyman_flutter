import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../../networks/apiservice.dart';
import '../models/auth_model.dart';
import '../models/maintenance_request_model.dart';
import '../models/room_model.dart';
import '../models/tenant_model.dart';
import '../screens/homelogged/requested_maintenance_list/requested_maintenance.dart';
import 'handy_man_provider.dart';

class MaintenanceRequestProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  Function? updateCurrentIndexCallback;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late String? token;
  late int? userId;
  late int? handymanId;

  void setUpdateCurrentIndexCallback(Function callback) {
    updateCurrentIndexCallback = callback;
  }

  void someFunctionThatChangesIndex(int newIndex) {
    if (updateCurrentIndexCallback != null) {
      updateCurrentIndexCallback!(newIndex);
    }
  }

  List<MaintenanceRequest?> _maintenanceRequestList = [];
  List<MaintenanceRequest?> get maintenanceRequestList =>
      _maintenanceRequestList;

  List<MaintenanceRequest?> get pendingRequests {
    return _maintenanceRequestList
        .where((request) => request?.status == 'pending')
        .toList();
  }

  List<MaintenanceRequest?> get requestedRequests {
    return _maintenanceRequestList.where((request) {
      return request?.status == 'requested' &&
          request?.handymanId == handymanId;
    }).toList();
  }

  List<MaintenanceRequest?> get assignedRequests {
    return _maintenanceRequestList.where((request) {
      return request?.status == 'assigned' && request?.handymanId == handymanId;
    }).toList();
  }

  MaintenanceRequest? get inProgressRequest {
    return _maintenanceRequestList.firstWhereOrNull(
      (request) =>
          request?.status == 'in_progress' && request?.handymanId == handymanId,
    );
  }

  List<MaintenanceRequest?> get forApproveRequest {
    return _maintenanceRequestList.where((request) {
      return request?.status == 'forApprove' &&
          request?.handymanId == handymanId;
    }).toList();
  }

  List<MaintenanceRequest?> get completedRequests {
    return _maintenanceRequestList.where((request) {
      return request?.status == 'completed' &&
          request?.handymanId == handymanId;
    }).toList();
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
    final handymanProvider = Provider.of<HandyManProvider>(
      context,
      listen: false,
    );
    token = handymanProvider.token;
    userId = handymanProvider.userId;
    handymanId = handymanProvider.handyman?.id;
  }

  Future<void> fetchMaintenanceRequest(BuildContext context) async {
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

      if (response != null && response.success) {
        print("success");
        _maintenanceRequestList = response.data.maintenanceRequests;
        notifyListeners();
      } else {
        print("failed");
      }
    } catch (e) {
      print("EXCEPTION: $e");
      return;
    }
  }

  Future<void> acceptMaintenanceRequest(
    BuildContext context,
    int maintenanceRequestId,
  ) async {
    _initMaintenanceRequestDetails(context);
    print(
      "from acceptMaintenanceRequest().maintenenceRequestId: $maintenanceRequestId",
    );
    print("from acceptMaintenanceRequest().handymanId: $handymanId");
    if (token == null || userId == null || handymanId == null) {
      print("no token detected at fetchHandyMan");
      return;
    }

    try {
      final response = await apiService.patchMaintenanceRequestToStatusRequest(
        token: token,
        maintenanceRequestId: maintenanceRequestId,
        handymanId: handymanId,
      );

      if (response != null && response.success) {
        await fetchMaintenanceRequest(context);
        Navigator.pop(context);
        if (updateCurrentIndexCallback != null) {
          updateCurrentIndexCallback!(1); // Pass the index value directly
        }
      }
    } catch (e) {
      print("EXCEPTION $e");
      return;
    }
  }

  Future<void> startMaintenanceRequest(
    BuildContext context,
    int maintenanceRequestId,
  ) async {
    _initMaintenanceRequestDetails(context);
    print(
      "from startMaintenanceRequest().maintenenceRequestId: $maintenanceRequestId",
    );

    if (token == null || userId == null || handymanId == null) {
      print("no token detected at fetchHandyMan");
      return;
    }

    try {
      final response = await apiService
          .patchMaintenanceRequestToStatusInProgress(
            token: token,
            maintenanceRequestId: maintenanceRequestId,
          );
      if (response != null && response.success) {
        await fetchMaintenanceRequest(context);
        Navigator.pop(context);
        if (updateCurrentIndexCallback != null) {
          updateCurrentIndexCallback!(3); // Pass the index value directly
        }
      } else {
        print("failed request startMaintenance");
        // print("object $errorMessage ");
        // print(response?.message );
      }
    } catch (e) {
      print("EXCEPTION $e");
      return;
    }
  }

  Future<void> forApproveMaintenanceRequest(
    BuildContext context,
    int maintenanceRequestId,
  ) async {
    _initMaintenanceRequestDetails(context);
    print(
      "from completeMaintenanceRequest().maintenenceRequestId: $maintenanceRequestId",
    );

    if (token == null || userId == null || handymanId == null) {
      print("no token detected at fetchHandyMan");
      return;
    }

    try {
      final response = await apiService.patchMaintenanceRequestToForApprove(
        token: token,
        maintenanceRequestId: maintenanceRequestId,
      );

      if (response != null && response.success) {
        await fetchMaintenanceRequest(context);
        // Navigator.pop(context);
        if (updateCurrentIndexCallback != null) {
          updateCurrentIndexCallback!(4); // Pass the index value directly
        }
      } else {
        print("failed request completeMaintenanceRequest");
      }
    } catch (e) {
      print("EXCEPTION $e");
      return;
    }
  }
}
