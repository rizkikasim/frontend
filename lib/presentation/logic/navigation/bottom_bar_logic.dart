import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/like/like_controller.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';
import 'package:mqfm_apps/utils/helpers/preferences_helper.dart';

class BottomBarLogic extends ChangeNotifier {
  final LikeController _likeController = LikeController();

  Set<int> _likedAudioIds = {};
  Set<int> get likedAudioIds => _likedAudioIds;

  String? message; // For SnackBar feedback

  Future<void> fetchLikedStatus() async {
    try {
      final token = await PreferencesHelper.getToken();
      if (token != null) {
        final response = await _likeController.getLikedAudios(token);
        if (response.data != null) {
          _likedAudioIds = response.data!.map((e) => e.id).toSet();
          notifyListeners();
        }
      }
    } catch (e) {
      LogHelper.error("BottomBarLogic", "Failed to fetch liked status: $e");
    }
  }

  bool isLiked(int audioId) {
    return _likedAudioIds.contains(audioId);
  }

  Future<void> toggleLike(int audioId) async {
    final bool wasLiked = _likedAudioIds.contains(audioId);

    // Optimistic Update
    if (wasLiked) {
      _likedAudioIds.remove(audioId);
    } else {
      _likedAudioIds.add(audioId);
    }
    notifyListeners();

    try {
      final token = await PreferencesHelper.getToken();

      if (token != null) {
        if (wasLiked) {
          await _likeController.unlikeAudio(token, audioId);
          message = "Dihapus dari favorit";
        } else {
          await _likeController.likeAudio(token, audioId);
          message = "Ditambahkan ke favorit";
        }
        notifyListeners();
        message = null; // Reset after notify
      } else {
        _revertState(audioId, wasLiked);
        message = "Silakan login terlebih dahulu";
        notifyListeners();
        message = null;
      }
    } catch (e) {
      _revertState(audioId, wasLiked);
      message = "Gagal: $e";
      LogHelper.error("BottomBarLogic", "Toggle like error", e as StackTrace?);
      notifyListeners();
      message = null;
    }
  }

  void _revertState(int audioId, bool wasLiked) {
    if (wasLiked) {
      _likedAudioIds.add(audioId);
    } else {
      _likedAudioIds.remove(audioId);
    }
    notifyListeners();
  }
}
