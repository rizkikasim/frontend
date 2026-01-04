import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';

class PlayerBackground extends StatelessWidget {
  final Widget child;

  const PlayerBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.playerGradient1,
            AppColors.playerGradient2,
            AppColors.playerGradient3,
          ],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
