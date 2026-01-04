import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchInputBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.black87, size: 28.r),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'What do you want to listen to?',
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 4.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
