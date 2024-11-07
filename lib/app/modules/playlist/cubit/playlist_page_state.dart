import 'package:equatable/equatable.dart';
import 'package:music_playlist/app/models/playlist_model.dart';

enum PlaylistPageStatus {
  initial,
  ready,
  failure,
  ;
}

class PlaylistPageState extends Equatable {
  final PlaylistPageStatus status;
  final Playlist? playlist;
  final Object? error;

  const PlaylistPageState({
    this.status = PlaylistPageStatus.initial,
    this.playlist,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        playlist,
        error,
      ];

  PlaylistPageState copyWith({
    PlaylistPageStatus? status,
    Playlist? playlist,
    Object? error,
  }) {
    return PlaylistPageState(
      status: status ?? this.status,
      playlist: playlist ?? this.playlist,
      error: error ?? this.error,
    );
  }

  PlaylistPageState ready() {
    return copyWith(
      status: PlaylistPageStatus.ready,
    );
  }

  PlaylistPageState failure(
    Object error,
  ) {
    return copyWith(
      status: PlaylistPageStatus.failure,
      error: error,
    );
  }
}
