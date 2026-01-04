import 'package:flutter/material.dart';
import 'package:mqfm_apps/presentation/molecules/profile/settings_tile.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsTile(
          icon: Icons.account_circle_outlined,
          title: 'Account',
          subtitle: 'Username • Close account',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.music_note_outlined,
          title: 'Content and display',
          subtitle: 'Canvas • App language',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.volume_up_outlined,
          title: 'Playback',
          subtitle: 'Gapless playback • Autoplay',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.lock_outline,
          title: 'Privacy and social',
          subtitle: 'Private session • Public playlists',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.notifications_none_outlined,
          title: 'Notifications',
          subtitle: 'Push • Email',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.devices_outlined,
          title: 'Apps and devices',
          subtitle: 'Google Maps • Spotify Connect control',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.arrow_circle_down_outlined,
          title: 'Data-saving and offline',
          subtitle: 'Data saver mode • Downloads over cellular',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.bar_chart_outlined,
          title: 'Media quality',
          subtitle: 'Wi-Fi streaming quality • Audio download quality',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.web_asset_outlined,
          title: 'Advertisements',
          subtitle: 'Tailored ads',
          onTap: () {},
        ),
        SettingsTile(
          icon: Icons.info_outline,
          title: 'About and support',
          subtitle: 'Version • Privacy Policy',
          onTap: () {},
        ),
      ],
    );
  }
}
