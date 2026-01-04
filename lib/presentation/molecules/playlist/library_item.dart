import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageAsset;
  final String? imageUrl;
  final Widget? customImage;
  final bool isRoundImage;
  final bool isPinned;

  const LibraryItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageAsset,
    this.imageUrl,
    this.customImage,
    this.isRoundImage = false,
    this.isPinned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          SizedBox(
            width: 64.w,
            height: 64.w,
            child:
                customImage ??
                Container(
                  decoration: BoxDecoration(
                    borderRadius: isRoundImage
                        ? BorderRadius.circular(32.r)
                        : BorderRadius.circular(4.r),
                    image: DecorationImage(
                      image: (imageUrl != null && imageUrl!.isNotEmpty)
                          ? NetworkImage(imageUrl!) as ImageProvider
                          : AssetImage(
                              imageAsset ?? 'assets/images/img_card.jpg',
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (isPinned) ...[
                      Transform.rotate(
                        angle: 45 * 3.14 / 180,
                        child: Icon(
                          Icons.push_pin,
                          color: AppColors.primaryClassic,
                          size: 12.r,
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
