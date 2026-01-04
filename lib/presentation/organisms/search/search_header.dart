import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.grey,
              backgroundImage: const AssetImage('assets/images/img_card.jpg'),
            ),
            SizedBox(width: 12.w),
            Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28.r),
      ],
    );
  }
}
