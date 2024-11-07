import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/manager/session_state.dart';
import 'package:music_playlist/app/models/playlist_model.dart';
import 'package:music_playlist/app/modules/home/cubit/home_page_cubit.dart';
import 'package:music_playlist/app/modules/home/cubit/home_page_state.dart';
import 'package:music_playlist/app/modules/home/widgets/home_playlist_tile.dart';
import 'package:music_playlist/app/utils/app_alert.dart';
import 'package:music_playlist/routes/extra_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomePageCubit get _cubit {
    return context.read<HomePageCubit>();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Playlist',
            ),
          ),
          body: _body(),
        );
      },
      listener: _listener,
    );
  }

  Widget _body() {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, sessionState) {
        final sessionCubit = context.read<SessionCubit>();
        final playlists = sessionState.playlists;
        return Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              final status = sessionCubit.playlistStatus(playlist);
              return HomePlaylistTile(
                playlist: playlist,
                status: status,
                onSelected: () {
                  _onSelectedPlaylist(playlist);
                },
                onTapPlay: () {
                  _cubit.onTapPlay(playlist);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _onSelectedPlaylist(Playlist playlist) {
    context.push(
      '/playlist',
      extra: ExtraData(
        playlist: playlist,
      ),
    );
  }

  void _listener(BuildContext context, HomePageState state) {
    switch (state.status) {
      case HomePageStatus.initial:
      case HomePageStatus.ready:
        break;

      case HomePageStatus.failure:
        AppAlert.error(context, error: state.error);
        break;
    }
  }
}
