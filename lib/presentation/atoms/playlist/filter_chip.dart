import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipAtom extends StatelessWidget {
  final String label;

  const FilterChipAtom({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceHighlight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.transparent),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
