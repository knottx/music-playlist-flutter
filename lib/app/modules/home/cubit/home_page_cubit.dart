import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/models/playlist_model.dart';
import 'package:music_playlist/app/modules/home/cubit/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  void onTapPlay(Playlist playlist) async {
    try {
      await SessionCubit.instance.playPlaylist(playlist);
    } catch (error) {
      emit(state.failure(error));
      emit(state.ready());
    }
  }
}
