import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/auth/auth_controller.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';
import 'package:mqfm_apps/utils/helpers/preferences_helper.dart';

class ProfileSettingsLogic extends ChangeNotifier {
  final AuthController _authController = AuthController();

  bool isLoading = false;
  String? message; // For SnackBar feedback (success/error)

  Future<bool> logout() async {
    isLoading = true;
    message = null;
    notifyListeners();

    try {
      final String? token = await PreferencesHelper.getToken();

      if (token != null) {
        LogHelper.info("ProfileSettingsLogic", "Attempting logout");
        await _authController.logout(token);
        await PreferencesHelper.removeToken();

        message = "Berhasil keluar";
        LogHelper.success("ProfileSettingsLogic", "Logout successful");
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Local logout (token missing)
        await PreferencesHelper.removeToken();
        LogHelper.info(
          "ProfileSettingsLogic",
          "Token missing, local logout performed",
        );
        isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e, stackTrace) {
      LogHelper.error("ProfileSettingsLogic", "Logout error", stackTrace);
      // Force logout on error? Usually safer to clear token anyway if desired,
      // but let's follow original logic: it caught error but didn't return 'false' explicitly in original 'finally' block handling.
      // Original logic: catch print error, finally isLoading=false, go('/login-form').
      // So effectively it always succeeds in navigating away.

      // I will allow it to return true so UI navigates.
      await PreferencesHelper.removeToken(); // Ensure token is gone
      isLoading = false;
      notifyListeners();
      return true;
    }
  }
}
