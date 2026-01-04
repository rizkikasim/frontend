import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/presentation/logic/navigation/bottom_bar_logic.dart';
import 'package:mqfm_apps/utils/manager/audio_player_manager.dart';

class MiniPlayer extends StatelessWidget {
  final BottomBarLogic logic;
  final AudioPlayerManager audioManager;

  const MiniPlayer({
    super.key,
    required this.logic,
    required this.audioManager,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Audio?>(
      valueListenable: audioManager.currentAudioNotifier,
      builder: (context, currentAudio, child) {
        if (currentAudio == null) return const SizedBox.shrink();

        // Use ListenableBuilder to rebuild when logic state changes (like status)
        return ListenableBuilder(
          listenable: logic,
          builder: (context, _) {
            final bool isLiked = logic.isLiked(currentAudio.id);

            return GestureDetector(
              onTap: () {
                context.push('/player/${currentAudio.id}');
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
                decoration: BoxDecoration(
                  color: AppColors.progressBar,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.background,
                      blurRadius: 20.r,
                      spreadRadius: 2.r,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: (currentAudio.thumbnail.isNotEmpty)
                                ? NetworkImage(currentAudio.thumbnail)
                                      as ImageProvider
                                : const AssetImage(
                                    'assets/images/img_card.jpg',
                                  ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentAudio.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              currentAudio.description,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.green : Colors.white,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          logic.toggleLike(currentAudio.id);
                        },
                      ),
                      StreamBuilder<PlayerState>(
                        stream: audioManager.player.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final playing = playerState?.playing;
                          final processingState = playerState?.processingState;

                          if (processingState == ProcessingState.loading ||
                              processingState == ProcessingState.buffering) {
                            return SizedBox(
                              width: 32.sp,
                              height: 32.sp,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }

                          return IconButton(
                            icon: Icon(
                              (playing == true)
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 32.sp,
                            ),
                            onPressed: () {
                              if (playing == true) {
                                audioManager.player.pause();
                              } else {
                                audioManager.player.play();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
