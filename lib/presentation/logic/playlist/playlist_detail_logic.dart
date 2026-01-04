import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/playlist/playlist_controller.dart';
import 'package:mqfm_apps/model/playlist/playlist_model.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';

class PlaylistDetailLogic extends ChangeNotifier {
  final PlaylistController _controller = PlaylistController();

  Playlist? playlist;
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchPlaylistDetail(String playlistId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final id = int.tryParse(playlistId) ?? 0;
      LogHelper.info(
        "PlaylistDetailLogic",
        "Fetching playlist detail for ID: $id",
      );

      final response = await _controller.getDetailPlaylist(id);

      if (response.status == 200 && response.data != null) {
        playlist = response.data;
        isLoading = false;
        LogHelper.success(
          "PlaylistDetailLogic",
          "Fetched playlist: ${playlist!.name}",
        );
        notifyListeners();
      } else {
        errorMessage = "Gagal: ${response.message}";
        isLoading = false;
        LogHelper.error(
          "PlaylistDetailLogic",
          "Failed to fetch: $errorMessage",
        );
        notifyListeners();
      }
    } catch (e) {
      errorMessage = "Error: $e";
      isLoading = false;
      LogHelper.error(
        "PlaylistDetailLogic",
        "Exception fetching playlist",
        e as StackTrace?,
      );
      notifyListeners();
    }
  }
}
