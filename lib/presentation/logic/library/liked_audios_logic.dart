import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/like/like_controller.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';
import 'package:mqfm_apps/utils/helpers/preferences_helper.dart';

class LikedAudiosLogic extends ChangeNotifier {
  final LikeController _controller = LikeController();
  List<Audio> likedAudios = [];
  bool isLoading = true;
  String? errorMessage;
  String? snackBarMessage; // For transient actions like unlike failure

  LikedAudiosLogic() {
    _fetchLikedAudios();
  }

  Future<void> _fetchLikedAudios() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final String? token = await PreferencesHelper.getToken();

      if (token == null) {
        errorMessage = "Silakan login terlebih dahulu";
        isLoading = false;
        notifyListeners();
        return;
      }

      LogHelper.info("LikedAudiosLogic", "Fetching liked audios...");
      final response = await _controller.getLikedAudios(token);

      if (response.status == 200 && response.data != null) {
        likedAudios = response.data!;
        isLoading = false;
        LogHelper.success(
          "LikedAudiosLogic",
          "Fetched ${likedAudios.length} liked audios",
        );
        notifyListeners();
      } else {
        errorMessage = response.message;
        isLoading = false;
        LogHelper.error(
          "LikedAudiosLogic",
          "Failed to get liked: ${response.message}",
        );
        notifyListeners();
      }
    } catch (e, stackTrace) {
      errorMessage = "Gagal memuat data. Periksa koneksi internet.";
      isLoading = false;
      LogHelper.error(
        "LikedAudiosLogic",
        "Exception fetching liked",
        stackTrace,
      );
      notifyListeners();
    }
  }

  Future<void> unlikeAudio(int index) async {
    if (index < 0 || index >= likedAudios.length) return;

    final audio = likedAudios[index];

    // Optimistic Update
    likedAudios.removeAt(index);
    notifyListeners();

    try {
      final String? token = await PreferencesHelper.getToken();

      if (token != null) {
        LogHelper.info("LikedAudiosLogic", "Unliking audio ${audio.id}");
        await _controller.unlikeAudio(token, audio.id);
        // Success assumed if no throw, or we can check result if controller returns boolean/response.
        // Original code didn't check response, just try-catch.
      }
    } catch (e, stackTrace) {
      // Revert on error
      likedAudios.insert(index, audio);
      snackBarMessage = "Gagal menghapus dari favorit";
      LogHelper.error("LikedAudiosLogic", "Failed to unlike", stackTrace);
      notifyListeners();
      snackBarMessage =
          null; // Reset immediately after notify? Or let UI consume.
    }
  }
}
