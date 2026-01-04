import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/model/playlist/playlist_model.dart';
import 'package:mqfm_apps/presentation/molecules/playlist/library_item.dart';

class LibraryPlaylistList extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<Playlist> playlists;

  const LibraryPlaylistList({
    super.key,
    required this.isLoading,
    this.errorMessage,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(color: Colors.green),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (playlists.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Belum ada playlist kajian.",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: playlists.map((playlist) {
        return InkWell(
          onTap: () {
            context.push(
              '/playlist/${playlist.id}',
            ); // Checking route: /playlist/:id -> /playlist-detail/:id
          },
          child: LibraryItem(
            title: playlist.name,
            subtitle: 'Playlist • ${playlist.audios.length} audio',
            imageUrl: playlist.imageUrl,
            isRoundImage: false,
          ),
        );
      }).toList(),
    );
  }
}
