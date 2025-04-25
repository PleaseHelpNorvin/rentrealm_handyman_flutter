import 'address_model.dart';

class Property {
  final int id;
  final String name;
  final String propertyPictureUrl;
  final String genderAllowed;
  final String type;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Address? address; // Nullable address

  Property({
    required this.id,
    required this.name,
    required this.propertyPictureUrl,
    required this.genderAllowed,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.address, // Nullable constructor
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      name: json['name'],
      propertyPictureUrl: json['property_picture_url'],
      genderAllowed: json['gender_allowed'],
      type: json['type'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      address:
          json['address'] != null
              ? Address.fromJson(json['address'])
              : null, // Handle null address
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'property_picture_url': propertyPictureUrl,
      'gender_allowed': genderAllowed,
      'type': type,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'address': address?.toJson(), // Safely handle null address
    };
  }
}
