import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';

class PlaylistTrackTile extends StatelessWidget {
  final Audio audio;

  const PlaylistTrackTile({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          image: DecorationImage(
            image: (audio.thumbnail.isNotEmpty)
                ? NetworkImage(audio.thumbnail)
                : const AssetImage('assets/images/img_card.jpg')
                      as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        audio.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        audio.description,
        style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        context.push('/player/${audio.id}');
      },
    );
  }
}
