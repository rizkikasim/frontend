import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/presentation/molecules/playlist/playlist_track_tile.dart';

class PlaylistTrackList extends StatelessWidget {
  final List<Audio> audios;

  const PlaylistTrackList({super.key, required this.audios});

  @override
  Widget build(BuildContext context) {
    if (audios.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            "Belum ada audio di playlist ini.",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    return Column(
      children: audios.map((audio) => PlaylistTrackTile(audio: audio)).toList(),
    );
  }
}
