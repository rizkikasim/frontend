import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerDisk extends StatelessWidget {
  final String imageUrl;

  const PlayerDisk({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340.w,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(
          image: (imageUrl.isNotEmpty)
              ? NetworkImage(imageUrl) as ImageProvider
              : const AssetImage('assets/images/img_card.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
    );
  }
}
