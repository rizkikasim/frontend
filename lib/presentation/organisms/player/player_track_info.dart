import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerTrackInfo extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onAddToPlaylist;

  const PlayerTrackInfo({
    super.key,
    required this.title,
    required this.description,
    required this.onAddToPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onAddToPlaylist,
          child: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 28.r,
          ),
        ),
      ],
    );
  }
}
