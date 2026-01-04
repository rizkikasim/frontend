import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/presentation/molecules/playlist/library_item.dart';

class LibraryStaticItems extends StatelessWidget {
  const LibraryStaticItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.import_export, color: Colors.white, size: 18.r),
            SizedBox(width: 8.w),
            Text(
              'Terbaru',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.grid_view, color: Colors.white, size: 18.r),
          ],
        ),
        SizedBox(height: 16.h),
        InkWell(
          onTap: () {
            context.push('/favorites');
          },
          child: LibraryItem(
            title: 'Kajian Favorit',
            subtitle: 'Playlist • 12 audio',
            isPinned: true,
            customImage: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.gradientBlue, AppColors.gradientGreen],
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Icon(Icons.favorite, color: Colors.white, size: 24.r),
              ),
            ),
          ),
        ),
        LibraryItem(
          title: 'Kajian Terbaru',
          subtitle: 'Diupdate hari ini',
          customImage: Container(
            decoration: BoxDecoration(
              color: AppColors
                  .catPurple, // Closest match to 5E35B1 (Deep Purple 600)
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Icon(
                Icons.notifications_active,
                color: AppColors.primaryClassic,
                size: 24.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
