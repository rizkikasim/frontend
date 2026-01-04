import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/logic/player/player_logic.dart';
import 'package:mqfm_apps/presentation/organisms/player/add_to_playlist_sheet.dart';

class PlayerDialogHelper {
  static void showPlaylistBottomSheet(BuildContext context, PlayerLogic logic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return AddToPlaylistSheet(
          playlistController: logic.playlistController,
          onPlaylistSelected: (id, name) async {
            await logic.addAudioToPlaylist(id, name);
          },
          onCreateNewPlaylist: () => showCreatePlaylistDialog(context, logic),
        );
      },
    );
  }

  static void showCreatePlaylistDialog(
    BuildContext context,
    PlayerLogic logic,
  ) {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceHeader,
          title: const Text(
            "Buat Playlist Baru",
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Nama Playlist",
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  Navigator.pop(context);
                  bool success = await logic.createPlaylist(
                    nameController.text,
                  );
                  if (success && context.mounted) {
                    showPlaylistBottomSheet(context, logic);
                  }
                }
              },
              child: const Text("Buat", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
