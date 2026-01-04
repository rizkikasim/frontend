import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/utils/app_colors.dart';

class ImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;

  const ImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.radius = 0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.r,
      height: height?.r,
      decoration: BoxDecoration(
        color: AppColors.placeholder,
        borderRadius: BorderRadius.circular(radius.r),
        shape:
            radius == 0 &&
                width != null &&
                height != null &&
                width ==
                    height // Heuristic for circle? No, explicit shape better.
            ? BoxShape.rectangle
            : BoxShape.rectangle, // Keep simple for now, using borderRadius
      ),
      child: child,
    );
  }
}
