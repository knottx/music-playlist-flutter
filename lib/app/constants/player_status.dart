import 'package:flutter/material.dart';

enum PlayerStatus {
  stopped,
  playing,
  paused,
  ;

  bool get isStopped => this == PlayerStatus.stopped;
  bool get isPlaying => this == PlayerStatus.playing;
  bool get isPaused => this == PlayerStatus.paused;

  IconData get iconData {
    switch (this) {
      case PlayerStatus.stopped:
      case PlayerStatus.paused:
        return Icons.play_arrow;
      case PlayerStatus.playing:
        return Icons.pause;
    }
  }

  IconData get nowPlayingIconData {
    switch (this) {
      case PlayerStatus.stopped:
      case PlayerStatus.paused:
        return Icons.play_arrow;
      case PlayerStatus.playing:
        return Icons.pause;
    }
  }
}
