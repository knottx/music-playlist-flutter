import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/manager/session_state.dart';
import 'package:music_playlist/app/models/playlist_model.dart';
import 'package:music_playlist/app/modules/playlist/cubit/playlist_page_cubit.dart';
import 'package:music_playlist/app/modules/playlist/cubit/playlist_page_state.dart';
import 'package:music_playlist/app/modules/playlist/widgets/playlist_music_tile.dart';
import 'package:music_playlist/app/utils/app_alert.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist? playlist;

  const PlaylistPage({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaylistPageCubit(playlist: playlist),
      child: const PlaylistView(),
    );
  }
}

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  PlaylistPageCubit get _cubit {
    return context.read<PlaylistPageCubit>();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaylistPageCubit, PlaylistPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.playlist?.name ?? '',
            ),
          ),
          body: _body(state),
        );
      },
      listener: _listener,
    );
  }

  Widget _body(PlaylistPageState state) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, sessionState) {
        final sessionCubit = context.read<SessionCubit>();
        final musics = state.playlist?.musics ?? [];
        return Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: musics.length,
            itemBuilder: (context, index) {
              final music = musics[index];
              final status = sessionCubit.musicStatus(music);
              return PlaylistMusicTile(
                music: music,
                status: status,
                onSelected: () {
                  _cubit.onTapPlay(music);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _listener(BuildContext context, PlaylistPageState state) {
    switch (state.status) {
      case PlaylistPageStatus.initial:
      case PlaylistPageStatus.ready:
        break;

      case PlaylistPageStatus.failure:
        AppAlert.error(context, error: state.error);
        break;
    }
  }
}
