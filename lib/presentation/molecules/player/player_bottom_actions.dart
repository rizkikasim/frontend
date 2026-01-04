import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerBottomActions extends StatelessWidget {
  const PlayerBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.speaker_group_outlined, color: Colors.white70, size: 24.r),
        Row(
          children: [
            Icon(Icons.share_outlined, color: Colors.white70, size: 24.r),
            SizedBox(width: 24.w),
            Icon(Icons.menu, color: Colors.white70, size: 24.r),
          ],
        ),
      ],
    );
  }
}
