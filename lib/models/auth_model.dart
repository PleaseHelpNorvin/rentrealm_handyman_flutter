class AuthResponse {
  bool success;
  String message;
  AuthData data;

  AuthResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // Factory constructor to create an instance from JSON
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      message: json['message'],
      data: AuthData.fromJson(json['data']),
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AuthData {
  String token;
  User user;

  AuthData({
    required this.token,
    required this.user,
  });

  // Factory constructor to create an instance from JSON
  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  String role;
  String createdAt;
  String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
