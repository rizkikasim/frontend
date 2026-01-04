import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/service/audio/audio_service.dart';

class AudioController {
  final AudioService _service = AudioService();

  Future<AudioResponse> getAllAudios() async {
    return await _service.getAudios();
  }

  Future<SingleAudioResponse> getDetailAudio(int id) async {
    return await _service.getAudioById(id);
  }

  Future<AudioResponse> getAudiosByCategory(int categoryId) async {
    final response = await getAllAudios();

    if (response.status == 200 && response.data != null) {
      if (categoryId == 0) return response; // 0 = All

      final filtered = response.data!
          .where((audio) => audio.categoryId == categoryId)
          .toList();

      return AudioResponse(status: 200, message: "Success", data: filtered);
    }
    return response;
  }

  Future<AudioResponse> searchAudios(String query) async {
    return await _service.searchAudios(query);
  }
}
