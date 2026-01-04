import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/atoms/profile/profile_avatar.dart';

class DashboardHeader extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const DashboardHeader({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 50.h,
        bottom: 16.h,
        left: 16.w,
        right: 16.w,
      ),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: ProfileAvatar(
              size: 32.r,
              backgroundColor: AppColors.placeholder,
              textColor: AppColors.backgroundBlack,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  return GestureDetector(
                    onTap: () => onCategorySelected(index),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? AppColors.primaryLight
                            : AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
