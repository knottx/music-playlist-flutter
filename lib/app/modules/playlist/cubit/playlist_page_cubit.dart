import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/models/music_model.dart';
import 'package:music_playlist/app/models/playlist_model.dart';
import 'package:music_playlist/app/modules/playlist/cubit/playlist_page_state.dart';

class PlaylistPageCubit extends Cubit<PlaylistPageState> {
  PlaylistPageCubit({
    required Playlist? playlist,
  }) : super(PlaylistPageState(playlist: playlist));

  void onTapPlay(Music music) async {
    try {
      await SessionCubit.instance.playNewMusic(music);
    } catch (error) {
      emit(state.failure(error));
      emit(state.ready());
    }
  }
}
