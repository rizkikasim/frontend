import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 30.r,
          ),
        ),
        Column(
          children: [
            Text(
              'PLAYING FROM PLAYLIST',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10.sp,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              "MQFM Radio",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        Icon(Icons.more_vert, color: Colors.white, size: 24.r),
      ],
    );
  }
}
