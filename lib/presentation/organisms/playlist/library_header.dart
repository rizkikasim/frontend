import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/atoms/profile/profile_avatar.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
          size: 32.r,
          backgroundColor: AppColors.placeholder,
          textColor: AppColors.backgroundBlack,
        ),
        SizedBox(width: 12.w),
        Text(
          'Pustaka Saya',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Icon(Icons.search, color: AppColors.textWhite, size: 28.r),
        SizedBox(width: 16.w),
        Icon(Icons.add, color: AppColors.textWhite, size: 30.r),
      ],
    );
  }
}
