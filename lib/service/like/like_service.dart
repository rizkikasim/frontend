import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/model/like/like_model.dart';

class LikeService {
  static const String domainUrl =
      'https://crispate-lawlessly-kadence.ngrok-free.dev';

  // Pastikan ada slash di akhir jika backend butuh, atau sesuaikan
  static const String baseUrl = '$domainUrl/api/user/likes/';

  Future<LikeResponse> toggleLike(String token, int audioId) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'audio_id': audioId}),
      );

      if (response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        return LikeResponse.fromJson(json);
      } else {
        throw Exception("Server Error: Status ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // --- FUNGSI BARU UNTUK HAPUS LIKE ---
  Future<bool> unlikeAudio(String token, int audioId) async {
    try {
      // PERHATIAN: Asumsi backend menerima DELETE /api/user/likes/{audioId}
      // Jika backend butuh ID Like (bukan ID Audio), logika parsing kita perlu diubah.
      final url = '$baseUrl$audioId';

      log("DELETE Request ke: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token',
        },
      );

      log("Status Delete: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        log("Gagal Delete: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Error Delete: $e");
      return false;
    }
  }

  Future<AudioResponse> getLikedAudios(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.body.isNotEmpty) {
        final json = jsonDecode(response.body);

        // Parsing nested audio object
        if (json['data'] != null && json['data'] is List) {
          final List rawData = json['data'];
          final List mappedData = rawData.map((item) {
            if (item is Map && item.containsKey('audio')) {
              return item['audio'];
            }
            return item;
          }).toList();
          json['data'] = mappedData;
        }

        return AudioResponse.fromJson(json);
      } else {
        throw Exception("Server Error: Status ${response.statusCode}");
      }
    } catch (e) {
      log("Error Parsing: $e");
      throw Exception(e.toString());
    }
  }
}
