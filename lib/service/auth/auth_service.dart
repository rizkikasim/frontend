import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mqfm_apps/model/auth/auth_model.dart';

class AuthService {
  // --- KONFIGURASI URL ---
  static const String domainUrl =
      'https://crispate-lawlessly-kadence.ngrok-free.dev';

  // Base API Path
  static const String baseUrl = '$domainUrl/api/user/auth';

  // --- REGISTER ---
  Future<AuthResponse> register(
    String username,
    String email,
    String password,
  ) async {
    return _postRequest('$baseUrl/register', {
      'username': username,
      'email': email,
      'password': password,
    });
  }

  // --- LOGIN ---
  Future<AuthResponse> login(String email, String password) async {
    return _postRequest('$baseUrl/login', {
      'email': email,
      'password': password,
    });
  }

  // --- ME (CEK PROFILE) ---
  Future<AuthResponse> me(String token) async {
    try {
      final url = '$baseUrl/me';
      log("GET Request ke: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token',
        },
      );

      log("Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        return AuthResponse.fromJson(json);
      } else {
        throw Exception(
          "Server Error: Balasan kosong (Status ${response.statusCode})",
        );
      }
    } catch (e) {
      log("Error Koneksi: $e");
      throw Exception(e.toString());
    }
  }

  // --- LOGOUT (BARU) ---
  Future<AuthResponse> logout(String token) async {
    try {
      final url = '$baseUrl/logout';
      log("POST Request ke: $url");

      // Logout biasanya method POST dan butuh Token
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token', // <-- Kirim Token
        },
      );

      log("Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        return AuthResponse.fromJson(json);
      } else {
        throw Exception(
          "Server Error: Balasan kosong (Status ${response.statusCode})",
        );
      }
    } catch (e) {
      log("Error Koneksi: $e");
      throw Exception(e.toString());
    }
  }

  // --- Helper Function untuk Request POST (Tanpa Token) ---
  Future<AuthResponse> _postRequest(
    String url,
    Map<String, String> body,
  ) async {
    try {
      log("POST Request ke: $url");

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode(body),
      );

      log("Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        return AuthResponse.fromJson(json);
      } else {
        throw Exception(
          "Server Error: Balasan kosong (Status ${response.statusCode})",
        );
      }
    } catch (e) {
      log("Error Koneksi: $e");
      throw Exception(e.toString());
    }
  }
}
