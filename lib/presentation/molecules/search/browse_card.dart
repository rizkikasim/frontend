import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrowseCard extends StatelessWidget {
  final String title;
  final Color color;
  final String imageAsset;

  const BrowseCard({
    super.key,
    required this.title,
    required this.color,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: -10.h,
            right: -15.w,
            child: Transform.rotate(
              angle: 25 * pi / 180,
              child: Container(
                height: 70.h,
                width: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
