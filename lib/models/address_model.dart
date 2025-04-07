class Address {
  final int id;
  final String line1;
  final String line2;
  final String province;
  final String country;
  final String postalCode;
  final double? latitude;
  final double? longitude;

  Address({
    required this.id,
    required this.line1,
    required this.line2,
    required this.province,
    required this.country,
    required this.postalCode,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      line1: json['line_1'],
      line2: json['line_2'],
      province: json['province'],
      country: json['country'],
      postalCode: json['postal_code'],
      latitude: json['latitude'] != null ? json['latitude'] : null,
      longitude: json['longitude'] != null ? json['longitude'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'line_1': line1,
      'line_2': line2,
      'province': province,
      'country': country,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
