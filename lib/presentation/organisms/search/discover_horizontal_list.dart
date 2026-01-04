import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/molecules/search/discover_card.dart';

class DiscoverHorizontalList extends StatelessWidget {
  const DiscoverHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover something new',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DiscoverCard(
                imageAsset: 'assets/images/img_card.jpg',
                tag: '#chill',
              ),
              SizedBox(width: 16.w),
              DiscoverCard(
                imageAsset: 'assets/images/img_card.jpg',
                tag: '#cinnamon',
              ),
              SizedBox(width: 16.w),
              DiscoverCard(
                imageAsset: 'assets/images/img_card.jpg',
                tag: '#hope',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
