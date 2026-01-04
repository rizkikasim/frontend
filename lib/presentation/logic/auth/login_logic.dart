import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/auth/auth_controller.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';
import 'package:mqfm_apps/utils/helpers/preferences_helper.dart';

class LoginLogic extends ChangeNotifier {
  final AuthController _authController = AuthController();

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      LogHelper.info("LoginLogic", "Attempting login for $email");
      final response = await _authController.login(email, password);

      if (response.status == 200) {
        if (response.data?.token != null) {
          await PreferencesHelper.saveToken(response.data!.token!);
        }

        successMessage = "Login Berhasil! Hai ${response.data?.username}";
        LogHelper.success("LoginLogic", "Login successful for $email");
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = "Gagal Masuk: ${response.message}";
        LogHelper.error("LoginLogic", "Login failed: ${response.message}");
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      errorMessage =
          "Error Koneksi: ${e.toString().replaceAll("Exception: ", "")}";
      LogHelper.error("LoginLogic", "Exception during login", stackTrace);
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
