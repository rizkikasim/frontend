import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/model/like/like_model.dart';
import 'package:mqfm_apps/service/like/like_service.dart';

class LikeController {
  final LikeService _service = LikeService();

  Future<LikeResponse> likeAudio(String token, int audioId) async {
    return await _service.toggleLike(token, audioId);
  }

  // Tambahkan ini
  Future<bool> unlikeAudio(String token, int audioId) async {
    return await _service.unlikeAudio(token, audioId);
  }

  Future<AudioResponse> getLikedAudios(String token) async {
    return await _service.getLikedAudios(token);
  }
}
