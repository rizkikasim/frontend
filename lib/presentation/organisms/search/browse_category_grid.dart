import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/molecules/search/browse_card.dart';

class BrowseCategoryGrid extends StatelessWidget {
  const BrowseCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Text(
          'Start browsing',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          children: const [
            BrowseCard(
              title: 'Music',
              color: AppColors.catPink,
              imageAsset: 'assets/images/img_card.jpg',
            ),
            BrowseCard(
              title: 'Podcasts',
              color: AppColors.catTeal,
              imageAsset: 'assets/images/img_card.jpg',
            ),
            BrowseCard(
              title: 'Live Events',
              color: AppColors.catPurple,
              imageAsset: 'assets/images/img_card.jpg',
            ),
            BrowseCard(
              title: 'K-Pop ON!\n(온) Hub',
              color: AppColors.catBlue,
              imageAsset: 'assets/images/img_card.jpg',
            ),
            BrowseCard(
              title: 'Wrapped\nLive Ind...',
              color: AppColors.catOrange,
              imageAsset: 'assets/images/img_card.jpg',
            ),
          ],
        ),
      ],
    );
  }
}
