import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  factory AudioPlayerManager() => _instance;
  AudioPlayerManager._internal();

  final AudioPlayer player = AudioPlayer();

  // Menyimpan ID lagu yang sedang aktif
  int? currentAudioId;

  // [BARU] Notifier untuk memberitahu BottomBar kalau lagu berubah
  final ValueNotifier<Audio?> currentAudioNotifier = ValueNotifier<Audio?>(
    null,
  );

  void dispose() {
    player.dispose();
  }
}
