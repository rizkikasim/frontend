import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mqfm_apps/controller/audio/audio_controller.dart';
import 'package:mqfm_apps/controller/playlist/playlist_controller.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/utils/manager/audio_player_manager.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';

class PlayerLogic extends ChangeNotifier {
  final AudioController _audioController = AudioController();
  final PlaylistController _playlistController = PlaylistController();
  final AudioPlayerManager _audioManager = AudioPlayerManager();

  AudioPlayer get player => _audioManager.player;
  PlaylistController get playlistController => _playlistController;

  Audio? audioData;
  bool isLoading = true;
  String? errorMessage;
  String? successMessage;

  Future<void> fetchDetailAudio(String audioId) async {
    try {
      final id = int.tryParse(audioId) ?? 0;
      LogHelper.info("PlayerLogic", "Fetching audio details for ID: $id");

      final response = await _audioController.getDetailAudio(id);

      if (response.status == 200 && response.data != null) {
        audioData = response.data;
        isLoading = false;
        LogHelper.success("PlayerLogic", "Fetched audio: ${audioData!.title}");
        notifyListeners();

        // Initialize Player
        _initPlayer(id);
      } else {
        errorMessage = response.message;
        isLoading = false;
        LogHelper.error("PlayerLogic", "Failed to fetch audio: $errorMessage");
        notifyListeners();
      }
    } catch (e, stackTrace) {
      errorMessage = "Gagal memuat audio";
      isLoading = false;
      LogHelper.error("PlayerLogic", "Exception fetching audio", stackTrace);
      notifyListeners();
    }
  }

  Future<void> _initPlayer(int id) async {
    if (audioData == null || audioData!.audioUrl.isEmpty) return;

    try {
      _audioManager.currentAudioNotifier.value = audioData;

      if (_audioManager.currentAudioId == id) {
        if (!player.playing) {
          player.play();
        }
      } else {
        await player.stop();
        await player.setUrl(audioData!.audioUrl);
        player.play();
        _audioManager.currentAudioId = id;
      }
    } catch (e) {
      errorMessage = "Gagal putar: $e";
      LogHelper.error(
        "PlayerLogic",
        "Player init error",
        e as StackTrace?,
      ); // Cast might fail if e is not stacktrace
      notifyListeners();
    }
  }

  Future<bool> createPlaylist(String name) async {
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      final response = await _playlistController.createPlaylist(name: name);
      if (response.status == 201 || response.status == 200) {
        successMessage = "Playlist '$name' berhasil dibuat!";
        notifyListeners();
        return true;
      } else {
        errorMessage = "Gagal: ${response.message}";
        notifyListeners();
        return false;
      }
    } catch (e) {
      errorMessage = "Error: $e";
      notifyListeners();
      return false;
    }
  }

  Future<bool> addAudioToPlaylist(int playlistId, String playlistName) async {
    if (audioData == null) return false;

    // Reset messages only handled by UI logic in this case?
    // Usually cleaner to return status, let UI show SnackBar.
    // logic.successMessage will be read by UI.

    try {
      LogHelper.info(
        "PlayerLogic",
        "Adding audio ${audioData!.id} to playlist $playlistId",
      );
      final success = await _playlistController.addAudioToPlaylist(
        playlistId: playlistId,
        audioId: audioData!.id,
      );

      if (success) {
        successMessage = "Berhasil ditambahkan ke '$playlistName'";
        notifyListeners();
        return true;
      } else {
        errorMessage = "Gagal menambahkan audio";
        notifyListeners();
        return false;
      }
    } catch (e) {
      errorMessage = e.toString().replaceAll("Exception:", "").trim();
      notifyListeners();
      return false;
    }
  }
}
