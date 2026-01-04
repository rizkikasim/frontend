import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/presentation/atoms/library/liked_audios_empty_state.dart';
import 'package:mqfm_apps/presentation/logic/library/liked_audios_logic.dart';
import 'package:mqfm_apps/presentation/organisms/library/liked_audios_list.dart';
import 'package:mqfm_apps/utils/helpers/message_helper.dart';

class LikedAudiosPage extends StatefulWidget {
  const LikedAudiosPage({super.key});

  @override
  State<LikedAudiosPage> createState() => _LikedAudiosPageState();
}

class _LikedAudiosPageState extends State<LikedAudiosPage> {
  final LikedAudiosLogic logic = LikedAudiosLogic();

  @override
  void initState() {
    super.initState();
    logic.addListener(_onLogicChange);
  }

  void _onLogicChange() {
    if (mounted) {
      if (logic.snackBarMessage != null) {
        MessageHelper.showError(context, logic.snackBarMessage!);
        // Logic should conceptually clear this, but assuming it transiently sets it.
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Kajian Favorit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: logic,
        builder: (context, child) {
          if (logic.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }

          if (logic.errorMessage != null) {
            return Center(
              child: Text(
                logic.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (logic.likedAudios.isEmpty) {
            return const LikedAudiosEmptyState();
          }

          return LikedAudiosList(
            audios: logic.likedAudios,
            onUnlike: logic.unlikeAudio,
          );
        },
      ),
    );
  }
}
