import 'package:flutter/material.dart';
import 'package:mqfm_apps/presentation/logic/navigation/bottom_bar_logic.dart';
import 'package:mqfm_apps/presentation/molecules/navigation/main_bottom_navigation.dart';
import 'package:mqfm_apps/presentation/organisms/player/mini_player.dart';
import 'package:mqfm_apps/utils/helpers/message_helper.dart';
import 'package:mqfm_apps/utils/manager/audio_player_manager.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final BottomBarLogic logic = BottomBarLogic();
  final AudioPlayerManager audioManager = AudioPlayerManager();

  @override
  void initState() {
    super.initState();
    logic.fetchLikedStatus();
    logic.addListener(_onLogicChange);
  }

  void _onLogicChange() {
    if (mounted && logic.message != null) {
      if (logic.message!.contains("Gagal") ||
          logic.message!.contains("Silakan login")) {
        MessageHelper.showError(context, logic.message!);
      } else {
        MessageHelper.showSuccess(
          context,
          logic.message!,
        ); // Or standard snackbar
      }
    }
  }

  @override
  void dispose() {
    logic.removeListener(_onLogicChange);
    logic.dispose(); // ChangeNotifier dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MiniPlayer(logic: logic, audioManager: audioManager),
        const MainBottomNavigation(),
      ],
    );
  }
}
