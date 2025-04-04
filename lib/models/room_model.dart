class Room {
  final int id;
  final int propertyId;
  final List<String> roomPictureUrl;
  final String roomCode;
  final String description;
  final String roomDetails;
  final String category;
  final String rentPrice;
  final String reservationFee;
  final int capacity;
  final int currentOccupants;
  final int minLease;
  final String size;
  final String status;
  final String unitType;
  final String createdAt;
  final String updatedAt;

  Room({
    required this.id,
    required this.propertyId,
    required this.roomPictureUrl,
    required this.roomCode,
    required this.description,
    required this.roomDetails,
    required this.category,
    required this.rentPrice,
    required this.reservationFee,
    required this.capacity,
    required this.currentOccupants,
    required this.minLease,
    required this.size,
    required this.status,
    required this.unitType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    // Handle room_picture_url: Check if it's a List<String> or a single String
    var roomPictureUrl = json['room_picture_url'] ?? [];
    if (roomPictureUrl is String) {
      roomPictureUrl = [roomPictureUrl];
    } else if (roomPictureUrl is List) {
      roomPictureUrl = List<String>.from(roomPictureUrl);
    }


    return Room(
      id: json['id'],
      propertyId: json['property_id'],
      roomPictureUrl: roomPictureUrl, // Now it's safely a List<String>
      roomCode: json['room_code'],
      description: json['description'],
      roomDetails: json['room_details'],
      category: json['category'],
      rentPrice: json['rent_price'],
      reservationFee: json['reservation_fee'],
      capacity: json['capacity'],
      currentOccupants: json['current_occupants'],
      minLease: json['min_lease'],
      size: json['size'],
      status: json['status'],
      unitType: json['unit_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
