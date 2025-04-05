// import 'dart:convert';
import './handy_man_model.dart';
import './tenant_model.dart';
import './room_model.dart';
import './auth_model.dart';

class MaintenanceRequestResponse {
  final bool success;
  final String message;
  final MaintenanceRequestData data;

  MaintenanceRequestResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MaintenanceRequestResponse.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequestResponse(
      success: json['success'],
      message: json['message'],
      data: MaintenanceRequestData.fromJson(json['data']),
    );
  }
}

class MaintenanceRequestData {
  final List<MaintenanceRequest> maintenanceRequests;

  MaintenanceRequestData({required this.maintenanceRequests});

  factory MaintenanceRequestData.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequestData(
      maintenanceRequests: List<MaintenanceRequest>.from(
        json['maintenance_requests'].map((x) => MaintenanceRequest.fromJson(x)),
      ),
    );
  }
}

class MaintenanceRequest {
  final int id;
  final String ticketCode;
  final int? tenantId;
  final int? roomId;
  final int? handymanId;
  final User? assignedBy;
  final String title;
  final String description;
  final List<dynamic> images;
  final String status;
  final String requestedAt;
  final String? assistedAt;
  final String? completedAt;
  final String createdAt;
  final String updatedAt;
  final Tenant? tenant;
  final Room? room;
  final Handyman? handyman;

  MaintenanceRequest({
    required this.id,
    required this.ticketCode,
    this.tenantId,
    this.roomId,
    this.handymanId,
    this.assignedBy,
    required this.title,
    required this.description,
    required this.images,
    required this.status,
    required this.requestedAt,
    this.assistedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.tenant,
    this.room,
    this.handyman,
  });

  factory MaintenanceRequest.fromJson(Map<String, dynamic> json) {
    print("from maintenance request model factory $json");

    print(
      'from maintenance request model factory tenant_id: ${json['tenant_id']}',
    );
    print('from maintenance request model factory room_id: ${json['room_id']}');
    print(
      'from maintenance request model factory handyman_id: ${json['handyman_id']}',
    );

    var images =
        json['images'] != null
            ? List<String>.from(json['images'].map((item) => item.toString()))
            : [];

    return MaintenanceRequest(
      id: json['id'] ?? 0, // Ensure id is properly parsed as int
      ticketCode: json['ticket_code'] ?? '', // Ensure ticketCode is a string
      tenantId: json['tenant_id'] != null ? json['tenant_id'] as int? : null,
      roomId: json['room_id'] != null ? json['room_id'] as int? : null,
      handymanId:
          json['handyman_id'] != null
              ? int.tryParse(json['handyman_id'].toString())
              : null,
      assignedBy:
          json['assigned_by'] != null
              ? User.fromJson(json['assigned_by'])
              : null,
      title: json['title'] ?? '', // Ensure title is a string
      description: json['description'] ?? '', // Ensure description is a string
      images: images,
      status: json['status'] ?? '', // Ensure status is a string
      requestedAt: json['requested_at'] ?? '',
      assistedAt: json['assisted_at'],
      completedAt: json['completed_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null,
      room: json['room'] != null ? Room.fromJson(json['room']) : null,
      handyman:
          json['handyman'] != null ? Handyman.fromJson(json['handyman']) : null,
    );
  }
}
