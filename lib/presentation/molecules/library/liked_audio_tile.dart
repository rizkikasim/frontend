import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:go_router/go_router.dart';

class LikedAudioTile extends StatelessWidget {
  final Audio audio;
  final VoidCallback onUnlike;

  const LikedAudioTile({
    super.key,
    required this.audio,
    required this.onUnlike,
  });

  @override
  Widget build(BuildContext context) {
    final dateDisplay = audio.createdAt.contains('T')
        ? audio.createdAt.split('T')[0]
        : audio.createdAt;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: Colors.grey[800],
            image: audio.thumbnail.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(audio.thumbnail),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {},
                  )
                : null,
          ),
          child: audio.thumbnail.isEmpty
              ? Icon(Icons.music_note, color: Colors.white, size: 24.r)
              : null,
        ),
        title: Text(
          audio.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          "Kajian • $dateDisplay",
          style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.green),
          onPressed: onUnlike,
        ),
        onTap: () {
          context.push('/player/${audio.id}');
        },
      ),
    );
  }
}
