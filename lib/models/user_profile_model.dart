import 'package:rentrealm_handyman_flutter/models/auth_model.dart';

class UserProfile {
  final int id;
  final int userId;
  final String profilePictureUrl;
  final String phoneNumber;
  final String socialMediaLinks;
  final String occupation;
  final String? driverLicenseNumber;
  final String? nationalId;
  final String? passportNumber;
  final String? socialSecurityNumber;
  final int? steps;
  final String createdAt;
  final String updatedAt;
  final User user;

  UserProfile({
    required this.id,
    required this.userId,
    required this.profilePictureUrl,
    required this.phoneNumber,
    required this.socialMediaLinks,
    required this.occupation,
    this.driverLicenseNumber,
    this.nationalId,
    this.passportNumber,
    this.socialSecurityNumber,
    this.steps,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      userId: json['user_id'],
      profilePictureUrl: json['profile_picture_url'],
      phoneNumber: json['phone_number'],
      socialMediaLinks: json['social_media_links'],
      occupation: json['occupation'],
      driverLicenseNumber: json['driver_license_number'],
      nationalId: json['national_id'],
      passportNumber: json['passport_number'],
      socialSecurityNumber: json['social_security_number'],
      steps: json['steps'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}
