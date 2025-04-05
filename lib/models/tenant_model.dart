import 'user_profile_model.dart';

class Tenant {
  final int id;
  final int profileId;
  final int rentalAgreementId;
  final String status;
  final String? evacuationDate;
  final String? moveOutDate;
  final String createdAt;
  final String updatedAt;
  final UserProfile userProfile;

  Tenant({
    required this.id,
    required this.profileId,
    required this.rentalAgreementId,
    required this.status,
    this.evacuationDate,
    this.moveOutDate,
    required this.createdAt,
    required this.updatedAt,
    required this.userProfile,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    print("from Tenant model: $json");

    return Tenant(
      id: json['id'],
      profileId: json['profile_id'],
      rentalAgreementId: json['rental_agreement_id'],
      status: json['status'],
      evacuationDate: json['evacuation_date'],
      moveOutDate: json['move_out_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userProfile: UserProfile.fromJson(json['user_profile']),
    );
  }
}
