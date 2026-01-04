import 'dart:io';
import 'package:mqfm_apps/model/playlist/playlist_model.dart';
import 'package:mqfm_apps/service/playlist/playlist_service.dart';

class PlaylistController {
  final PlaylistService _service = PlaylistService();

  Future<PlaylistListResponse> getAllPlaylists() async {
    final response = await _service.getPlaylists();
    return PlaylistListResponse.fromJson(response);
  }

  Future<PlaylistResponse> getDetailPlaylist(int id) async {
    final response = await _service.getDetailPlaylist(id);
    return PlaylistResponse.fromJson(response);
  }

  Future<PlaylistResponse> createPlaylist({
    required String name,
    File? imageFile,
  }) async {
    final response = await _service.createPlaylist(
      name: name,
      imageFile: imageFile,
    );
    return PlaylistResponse.fromJson(response);
  }

  Future<bool> addAudioToPlaylist({
    required int playlistId,
    required int audioId,
  }) async {
    return await _service.addAudioToPlaylist(
      playlistId: playlistId,
      audioId: audioId,
    );
  }
}
