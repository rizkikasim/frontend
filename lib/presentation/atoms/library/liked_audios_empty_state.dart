import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikedAudiosEmptyState extends StatelessWidget {
  const LikedAudiosEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64.r, color: Colors.grey),
          SizedBox(height: 16.h),
          Text(
            "Belum ada kajian yang disukai",
            style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
