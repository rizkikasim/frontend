import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistService {
  static const String domainUrl =
      'https://crispate-lawlessly-kadence.ngrok-free.dev';
  static const String baseUrl = '$domainUrl/api/user/playlists';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    return {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> getPlaylists() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('$baseUrl/'), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception(
          "Unauthorized (401). Token mungkin expired atau tidak valid.",
        );
      } else {
        throw Exception('Failed to load playlists: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDetailPlaylist(int id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to load playlist detail: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> createPlaylist({
    required String name,
    File? imageFile,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      var uri = Uri.parse('$baseUrl/');
      var request = http.MultipartRequest('POST', uri);

      Map<String, String> headers = {'ngrok-skip-browser-warning': 'true'};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
      request.headers.addAll(headers);

      request.fields['name'] = name;

      if (imageFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'image_file',
          imageFile.path,
        );
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create playlist: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> addAudioToPlaylist({
    required int playlistId,
    required int audioId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      var uri = Uri.parse('$baseUrl/add-audio');

      var request = http.MultipartRequest('POST', uri);

      Map<String, String> headers = {'ngrok-skip-browser-warning': 'true'};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
      request.headers.addAll(headers);

      request.fields['playlist_id'] = playlistId.toString();
      request.fields['audio_id'] = audioId.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        String errorMessage = 'Gagal menambahkan audio';
        try {
          final body = jsonDecode(response.body);
          if (body['message'] != null) {
            errorMessage = body['message'];
          }
        } catch (_) {
          errorMessage = response.body;
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
