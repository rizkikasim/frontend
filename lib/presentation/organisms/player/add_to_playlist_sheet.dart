import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/controller/playlist/playlist_controller.dart';
import 'package:mqfm_apps/model/playlist/playlist_model.dart';

class AddToPlaylistSheet extends StatelessWidget {
  final PlaylistController playlistController;
  final Function(int playlistId, String playlistName) onPlaylistSelected;
  final VoidCallback onCreateNewPlaylist;

  const AddToPlaylistSheet({
    super.key,
    required this.playlistController,
    required this.onPlaylistSelected,
    required this.onCreateNewPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Tambahkan ke Playlist",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ListTile(
            leading: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(Icons.add, color: Colors.white, size: 28.r),
            ),
            title: Text(
              "Playlist Baru",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onCreateNewPlaylist();
            },
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: FutureBuilder<PlaylistListResponse>(
              future: playlistController.getAllPlaylists(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (snapshot.hasError ||
                    snapshot.data?.data == null ||
                    snapshot.data!.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "Belum ada playlist",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  );
                }

                final playlists = snapshot.data!.data!;
                return ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return ListTile(
                      leading: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: (playlist.imageUrl.isNotEmpty)
                                ? NetworkImage(playlist.imageUrl)
                                      as ImageProvider
                                : const AssetImage(
                                    'assets/images/img_card.jpg',
                                  ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        playlist.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "${playlist.audios.length} audio",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        onPlaylistSelected(playlist.id, playlist.name);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
