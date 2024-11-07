import 'package:equatable/equatable.dart';
import 'package:music_playlist/app/constants/player_status.dart';
import 'package:music_playlist/app/models/lyrics_model.dart';
import 'package:music_playlist/app/models/music_model.dart';
import 'package:music_playlist/app/models/playlist_model.dart';

class SessionState extends Equatable {
  final PlayerStatus playerStatus;
  final Music? currentMusic;
  final Duration? maxDuration;
  final Duration? currentPosition;
  final List<Playlist> playlists;
  final bool showBottomSheetNowPlaying;
  final List<Music> historyMusics;
  final List<Music> upNextMusics;
  final bool onSeek;
  final List<Lyrics> allLyrics;

  const SessionState({
    this.playerStatus = PlayerStatus.stopped,
    this.currentMusic,
    this.maxDuration,
    this.currentPosition,
    this.playlists = const [],
    this.showBottomSheetNowPlaying = false,
    this.historyMusics = const [],
    this.upNextMusics = const [],
    this.onSeek = false,
    this.allLyrics = const [],
  });

  @override
  List<Object?> get props => [
        playerStatus,
        currentMusic,
        maxDuration,
        currentPosition,
        playlists,
        showBottomSheetNowPlaying,
        historyMusics,
        upNextMusics,
        onSeek,
        allLyrics,
      ];

  SessionState copyWith({
    PlayerStatus? playerStatus,
    Music? currentMusic,
    Duration? maxDuration,
    Duration? currentPosition,
    List<Playlist>? playlists,
    bool? showBottomSheetNowPlaying,
    List<Music>? historyMusics,
    List<Music>? upNextMusics,
    bool? onSeek,
    List<Lyrics>? allLyrics,
  }) {
    return SessionState(
      playerStatus: playerStatus ?? this.playerStatus,
      currentMusic: currentMusic ?? this.currentMusic,
      maxDuration: maxDuration ?? this.maxDuration,
      currentPosition: currentPosition ?? this.currentPosition,
      playlists: playlists ?? this.playlists,
      showBottomSheetNowPlaying:
          showBottomSheetNowPlaying ?? this.showBottomSheetNowPlaying,
      historyMusics: historyMusics ?? this.historyMusics,
      upNextMusics: upNextMusics ?? this.upNextMusics,
      onSeek: onSeek ?? this.onSeek,
      allLyrics: allLyrics ?? this.allLyrics,
    );
  }
}
