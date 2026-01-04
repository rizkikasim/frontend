import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            Icons.home_filled,
            'home',
            true, // Logic for active state? User's original code had 'true' hardcoded for home...?
            // Actually, generic BottomBar usually highlights based on route.
            // But user provided code: `_buildNavItem(Icons.home_filled, 'home', true, ...)`
            // I will preserve exact behavior for now, logic can be improved later if requested.
            () => context.go('/dashboard'),
          ),
          _buildNavItem(
            context,
            Icons.search,
            'search',
            false,
            () => context.push('/search'),
          ),
          _buildNavItem(
            context,
            Icons.queue_music,
            'playlist',
            false,
            () => context.push('/playlist'),
          ),
          _buildNavItem(
            context,
            Icons.favorite_border,
            'like',
            false,
            () => context.push('/favorites'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.white : Colors.grey, size: 26.sp),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
