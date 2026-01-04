class AuthResponse {
  final int status;
  final String message;
  final UserData? data;

  AuthResponse({required this.status, required this.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class UserData {
  final int id;
  final String username;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String? token; // <-- TAMBAHAN: Field Token (Nullable)

  UserData({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.token, // <-- Tambahkan di constructor
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      token: json['token'], // <-- Ambil token dari JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'token': token, // <-- Masukkan ke JSON
    };
  }
}
