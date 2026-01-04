import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mqfm_apps/presentation/atoms/profile/logout_button.dart';
import 'package:mqfm_apps/presentation/logic/profile/profile_settings_logic.dart';
import 'package:mqfm_apps/presentation/organisms/profile/settings_list.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:mqfm_apps/utils/helpers/message_helper.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final ProfileSettingsLogic logic = ProfileSettingsLogic();

  Future<void> _handleLogout() async {
    final success = await logic.logout();
    if (mounted) {
      if (logic.message != null) {
        MessageHelper.showSuccess(
          context,
          logic.message!,
        ); // Or generic message
      }

      if (success) {
        context.go('/login-form');
      }
    }
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textWhite),
            onPressed: () {},
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: logic,
        builder: (context, child) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              const SettingsList(),
              const SizedBox(height: 32),
              LogoutButton(
                isLoading: logic.isLoading,
                onPressed: _handleLogout,
              ),
              const SizedBox(height: 48),
            ],
          );
        },
      ),
    );
  }
}
