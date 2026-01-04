import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: const DecorationImage(
          image: AssetImage('assets/images/img_card.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          const Align(alignment: Alignment.center),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 32.r,
              height: 32.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_outward,
                color: Colors.black,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
