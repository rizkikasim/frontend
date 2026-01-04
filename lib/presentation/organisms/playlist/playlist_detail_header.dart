import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/model/playlist/playlist_model.dart';

class PlaylistDetailHeader extends StatelessWidget {
  final Playlist playlist;

  const PlaylistDetailHeader({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 200.w,
            height: 200.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: (playlist.imageUrl.isNotEmpty)
                    ? NetworkImage(playlist.imageUrl)
                    : const AssetImage('assets/images/img_card.jpg')
                          as ImageProvider,
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20.r,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          playlist.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Dibuat oleh User #${playlist.userId}",
          style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
        ),
      ],
    );
  }
}
