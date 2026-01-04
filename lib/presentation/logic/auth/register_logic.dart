import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/auth/auth_controller.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';

class RegisterLogic extends ChangeNotifier {
  final AuthController _authController = AuthController();

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  Future<bool> register(String username, String email, String password) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      LogHelper.info(
        "RegisterLogic",
        "Attempting registration for $username ($email)",
      );
      final response = await _authController.register(
        username,
        email,
        password,
      );

      if (response.status == 201) {
        successMessage = "Berhasil: ${response.message}";
        LogHelper.success(
          "RegisterLogic",
          "Registration successful for $username",
        );
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = "Gagal: ${response.message}";
        LogHelper.error(
          "RegisterLogic",
          "Registration failed: ${response.message}",
        );
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      errorMessage = "Error: ${e.toString().replaceAll("Exception: ", "")}";
      LogHelper.error(
        "RegisterLogic",
        "Exception during registration",
        stackTrace,
      );
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
