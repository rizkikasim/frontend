import 'package:mqfm_apps/model/auth/auth_model.dart';
import 'package:mqfm_apps/service/auth/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  // --- REGISTER ---
  Future<AuthResponse> register(
    String username,
    String email,
    String password,
  ) async {
    return await _authService.register(username, email, password);
  }

  // --- LOGIN ---
  Future<AuthResponse> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  // --- ME (CEK PROFILE) ---
  Future<AuthResponse> me(String token) async {
    return await _authService.me(token);
  }

  // --- LOGOUT (BARU) ---
  Future<AuthResponse> logout(String token) async {
    return await _authService.logout(token);
  }
}
