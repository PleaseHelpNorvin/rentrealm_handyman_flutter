import 'dart:convert';
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

  MaintenanceRequestData({
    required this.maintenanceRequests,
  });

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
  final int tenantId;
  final int roomId;
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
    required this.tenantId,
    required this.roomId,
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
  // Safely handle the 'images' field and ensure it's a List<String>
  var images = json['images'] != null
      ? List<String>.from(json['images'].map((item) => item.toString()))
      : [];

  return MaintenanceRequest(
    id: json['id'],
    ticketCode: json['ticket_code'],
    tenantId: json['tenant_id'],
    roomId: json['room_id'],
    handymanId: json['handyman_id'],
    assignedBy: json['assigned_by'] != null
        ? User.fromJson(json['assigned_by'])
        : null,
    title: json['title'],
    description: json['description'],
    images: images,
    status: json['status'],
    requestedAt: json['requested_at'],
    assistedAt: json['assisted_at'],
    completedAt: json['completed_at'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null,
    room: json['room'] != null ? Room.fromJson(json['room']) : null,
   handyman: json['handyman'] != null
          ? Handyman.fromJson(json['handyman'])
          : null, // Safe check for handyman field
  );
}


}
// class AssignedBy {
//   final int id;
//   final String name;
//   final String email;
//   final String? emailVerifiedAt;
//   final String role;
//   final String createdAt;
//   final String updatedAt;

//   AssignedBy({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.emailVerifiedAt,
//     required this.role,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory AssignedBy.fromJson(Map<String, dynamic> json) {
//     return AssignedBy(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       emailVerifiedAt: json['email_verified_at'],
//       role: json['role'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

// class Tenant {
//   final int id;
//   final int profileId;
//   final int rentalAgreementId;
//   final String status;
//   final String? evacuationDate;
//   final String? moveOutDate;
//   final String createdAt;
//   final String updatedAt;

//   Tenant({
//     required this.id,
//     required this.profileId,
//     required this.rentalAgreementId,
//     required this.status,
//     this.evacuationDate,
//     this.moveOutDate,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Tenant.fromJson(Map<String, dynamic> json) {
//     return Tenant(
//       id: json['id'],
//       profileId: json['profile_id'],
//       rentalAgreementId: json['rental_agreement_id'],
//       status: json['status'],
//       evacuationDate: json['evacuation_date'],
//       moveOutDate: json['move_out_date'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

// class Room {
//   final int id;
//   final int propertyId;
//   final List<String> roomPictureUrl;
//   final String roomCode;
//   final String description;
//   final String roomDetails;
//   final String category;
//   final String rentPrice;
//   final String reservationFee;
//   final int capacity;
//   final int currentOccupants;
//   final int minLease;
//   final String size;
//   final String status;
//   final String unitType;
//   final String createdAt;
//   final String updatedAt;

//   Room({
//     required this.id,
//     required this.propertyId,
//     required this.roomPictureUrl,
//     required this.roomCode,
//     required this.description,
//     required this.roomDetails,
//     required this.category,
//     required this.rentPrice,
//     required this.reservationFee,
//     required this.capacity,
//     required this.currentOccupants,
//     required this.minLease,
//     required this.size,
//     required this.status,
//     required this.unitType,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json['id'],
//       propertyId: json['property_id'],
//       roomPictureUrl: List<String>.from(json['room_picture_url']),
//       roomCode: json['room_code'],
//       description: json['description'],
//       roomDetails: json['room_details'],
//       category: json['category'],
//       rentPrice: json['rent_price'],
//       reservationFee: json['reservation_fee'],
//       capacity: json['capacity'],
//       currentOccupants: json['current_occupants'],
//       minLease: json['min_lease'],
//       size: json['size'],
//       status: json['status'],
//       unitType: json['unit_type'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

// class Handyman {
//   final int id;
//   final int userId;
//   final String status;
//   final String createdAt;
//   final String updatedAt;

//   Handyman({
//     required this.id,
//     required this.userId,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Handyman.fromJson(Map<String, dynamic> json) {
//     return Handyman(
//       id: json['id'],
//       userId: json['user_id'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }
