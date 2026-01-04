import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/atoms/player/player_background.dart';
import 'package:mqfm_apps/presentation/logic/player/player_logic.dart';
import 'package:mqfm_apps/presentation/molecules/player/player_bottom_actions.dart';
import 'package:mqfm_apps/presentation/organisms/player/player_controls.dart';
import 'package:mqfm_apps/presentation/organisms/player/player_dialog_helper.dart';
import 'package:mqfm_apps/presentation/organisms/player/player_disk.dart';
import 'package:mqfm_apps/presentation/organisms/player/player_header.dart';
import 'package:mqfm_apps/presentation/organisms/player/player_track_info.dart';
import 'package:mqfm_apps/utils/helpers/message_helper.dart';

class PlayerPage extends StatefulWidget {
  final String audioId;

  const PlayerPage({super.key, required this.audioId});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final PlayerLogic logic = PlayerLogic();

  @override
  void initState() {
    super.initState();
    logic.fetchDetailAudio(widget.audioId);
    logic.addListener(_onLogicChange);
  }

  void _onLogicChange() {
    if (mounted) {
      if (logic.errorMessage != null) {
        MessageHelper.showError(context, logic.errorMessage!);
      }
      if (logic.successMessage != null) {
        MessageHelper.showSuccess(context, logic.successMessage!);
      }
    }
  }

  @override
  void dispose() {
    logic.removeListener(_onLogicChange);
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerBackground(
        child: ListenableBuilder(
          listenable: logic,
          builder: (context, child) {
            if (logic.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.textWhite),
              );
            }

            if (logic.audioData == null) {
              return const Center(
                child: Text(
                  "Audio tidak ditemukan",
                  style: TextStyle(color: AppColors.textWhite),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              child: Column(
                children: [
                  const PlayerHeader(),
                  const Spacer(),
                  PlayerDisk(imageUrl: logic.audioData!.thumbnail),
                  const Spacer(),
                  PlayerTrackInfo(
                    title: logic.audioData!.title,
                    description: logic.audioData!.description,
                    onAddToPlaylist: () =>
                        PlayerDialogHelper.showPlaylistBottomSheet(
                          context,
                          logic,
                        ),
                  ),
                  SizedBox(height: 24.h),
                  PlayerControls(player: logic.player),
                  SizedBox(height: 30.h),
                  const PlayerBottomActions(),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
