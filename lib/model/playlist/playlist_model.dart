import 'package:mqfm_apps/model/audio/audio_model.dart';

class PlaylistListResponse {
  final int status;
  final String message;
  final List<Playlist>? data;

  PlaylistListResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory PlaylistListResponse.fromJson(Map<String, dynamic> json) {
    return PlaylistListResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Playlist.fromJson(i)).toList()
          : [],
    );
  }
}

class PlaylistResponse {
  final int status;
  final String message;
  final Playlist? data;

  PlaylistResponse({required this.status, required this.message, this.data});

  factory PlaylistResponse.fromJson(Map<String, dynamic> json) {
    return PlaylistResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Playlist.fromJson(json['data']) : null,
    );
  }
}

class Playlist {
  final int id;
  final int userId;
  final String name;
  final String imageUrl;
  final List<Audio> audios;
  final String createdAt;
  final String updatedAt;

  Playlist({
    required this.id,
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.audios,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    const String domainUrl =
        'https://angella-nevoid-becalmingly.ngrok-free.dev';

    String fixUrl(String? path) {
      if (path == null || path.isEmpty) return "";
      if (path.startsWith("http") || path.startsWith("https")) {
        return path;
      }
      String cleanPath = path.startsWith('/') ? path.substring(1) : path;
      return "$domainUrl/$cleanPath";
    }

    return Playlist(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      imageUrl: fixUrl(json['image_url']),
      audios: json['audios'] != null
          ? (json['audios'] as List).map((i) => Audio.fromJson(i)).toList()
          : [],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}
