import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/logic/playlist/playlist_logic.dart';
import 'package:mqfm_apps/presentation/organisms/navigation/bottom_bar.dart';
import 'package:mqfm_apps/presentation/organisms/playlist/library_filter_list.dart';
import 'package:mqfm_apps/presentation/organisms/playlist/library_header.dart';
import 'package:mqfm_apps/presentation/organisms/playlist/library_playlist_list.dart';
import 'package:mqfm_apps/presentation/organisms/playlist/library_static_items.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final PlaylistLogic logic = PlaylistLogic();

  @override
  void initState() {
    super.initState();
    logic.fetchPlaylists();
  }

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: logic.fetchPlaylists,
          color: AppColors.primaryClassic,
          backgroundColor: AppColors.surfaceHeader,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LibraryHeader(),
                SizedBox(height: 24.h),
                const LibraryFilterList(),
                SizedBox(height: 24.h),
                const LibraryStaticItems(),
                ListenableBuilder(
                  listenable: logic,
                  builder: (context, child) {
                    return LibraryPlaylistList(
                      isLoading: logic.isLoading,
                      errorMessage: logic.errorMessage,
                      playlists: logic.playlists,
                    );
                  },
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
