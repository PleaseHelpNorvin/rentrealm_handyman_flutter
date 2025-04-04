
import 'auth_model.dart';

class HandyManResponse {
  bool success;
  String message;
  HandyManData data;

  HandyManResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HandyManResponse.fromJson(Map<String, dynamic> json) {
    return HandyManResponse(
      success: json['success'],
      message: json['message'],
      data: HandyManData.fromJson(json['data']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'success': success,
  //     'message': message,
  //     'data': data.toJson(),
  //   };
  // }
}

class HandyManData {
  List<Handyman> handymans;

  HandyManData({
    required this.handymans,
  });

  factory HandyManData.fromJson(Map<String, dynamic> json) {
    var list = json['handymans'] as List;
    List<Handyman> handymansList = list.map((i) => Handyman.fromJson(i)).toList();
    return HandyManData(
      handymans: handymansList,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'handymans': handymans.map((i) => i.toJson()).toList(),
  //   };
  // }
}

class Handyman {
  int id;
  int userId;
  String status;
  String createdAt;
  String updatedAt;
  User? user;

  Handyman({
    required this.id,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory Handyman.fromJson(Map<String, dynamic> json) {
    return Handyman(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null, // Handle null user
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(), // Include user only if it's not null
    };
  }
}

// class User {
//   int id;
//   String name;
//   String email;
//   String? emailVerifiedAt;
//   String role;
//   String createdAt;
//   String updatedAt;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.emailVerifiedAt,
//     required this.role,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       emailVerifiedAt: json['email_verified_at'],
//       role: json['role'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'email_verified_at': emailVerifiedAt,
//       'role': role,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }
