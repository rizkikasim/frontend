import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/presentation/molecules/library/liked_audio_tile.dart';

class LikedAudiosList extends StatelessWidget {
  final List<Audio> audios;
  final Function(int) onUnlike;

  const LikedAudiosList({
    super.key,
    required this.audios,
    required this.onUnlike,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemCount: audios.length,
      itemBuilder: (context, index) {
        return LikedAudioTile(
          audio: audios[index],
          onUnlike: () => onUnlike(index),
        );
      },
    );
  }
}
