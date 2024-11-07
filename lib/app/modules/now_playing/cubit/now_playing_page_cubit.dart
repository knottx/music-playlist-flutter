import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/models/music_model.dart';
import 'package:music_playlist/app/modules/now_playing/cubit/now_playing_page_state.dart';

class NowPlayingPageCubit extends Cubit<NowPlayingPageState> {
  NowPlayingPageCubit() : super(const NowPlayingPageState());

  void onTapPlay() async {
    try {
      final currentMusic = SessionCubit.instance.state.currentMusic;
      if (currentMusic != null) {
        await SessionCubit.instance.resumeMusic(currentMusic);
      }
    } catch (error) {
      emit(state.failure(error));
      emit(state.ready());
    }
  }

  void onTapSkipPrevious() async {
    try {
      await SessionCubit.instance.playPrevious();
    } catch (error) {
      emit(state.failure(error));
      emit(state.ready());
    }
  }

  void onTapSkipNext() async {
    try {
      await SessionCubit.instance.playNext();
    } catch (error) {
      emit(state.failure(error));
      emit(state.ready());
    }
  }

  void onSeekEnd(double value) async {
    try {
      await SessionCubit.instance.confirmSeek(value);
    } catch (error) {
      emit(state.failure(error));
      emit(state.ready());
    }
  }

  void playUpNext(Music music) async {
    try {
      await SessionCubit.instance.playUpNext(music);
    } catch (error) {
      emit(state.failure(error));
      emit(state.ready());
    }
  }
}
