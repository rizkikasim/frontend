import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class PlayerControls extends StatelessWidget {
  final AudioPlayer player;

  const PlayerControls({super.key, required this.player});

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            final duration = player.duration ?? Duration.zero;

            double sliderValue = position.inSeconds.toDouble();
            double maxDuration = duration.inSeconds.toDouble();
            if (maxDuration <= 0) maxDuration = 1;
            if (sliderValue > maxDuration) sliderValue = maxDuration;

            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 14.r),
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                    thumbColor: Colors.white,
                  ),
                  child: Slider(
                    min: 0,
                    max: maxDuration,
                    value: sliderValue,
                    onChanged: (value) {
                      player.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(position),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        _formatDuration(duration),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.shuffle, color: AppColors.primaryClassic, size: 26.r),
            Icon(Icons.skip_previous, color: Colors.white, size: 42.r),
            StreamBuilder<PlayerState>(
              stream: player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;

                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    height: 72.r,
                    width: 72.r,
                    padding: EdgeInsets.all(20.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircularProgressIndicator(color: Colors.black),
                  );
                } else if (playing != true) {
                  return GestureDetector(
                    onTap: player.play,
                    child: Container(
                      height: 72.r,
                      width: 72.r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 38.r,
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: player.pause,
                    child: Container(
                      height: 72.r,
                      width: 72.r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.pause, color: Colors.black, size: 38.r),
                    ),
                  );
                }
              },
            ),
            Icon(Icons.skip_next, color: Colors.white, size: 42.r),
            Icon(Icons.timer_outlined, color: Colors.white, size: 26.r),
          ],
        ),
      ],
    );
  }
}
