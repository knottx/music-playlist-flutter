import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/manager/session_state.dart';
import 'package:music_playlist/app/modules/now_playing/cubit/now_playing_page_cubit.dart';
import 'package:music_playlist/app/modules/now_playing/cubit/now_playing_page_state.dart';
import 'package:music_playlist/app/modules/now_playing/widgets/now_playing_header_tile.dart';
import 'package:music_playlist/app/modules/now_playing/widgets/now_playing_up_next_tile.dart';
import 'package:music_playlist/app/utils/app_alert.dart';
import 'package:music_playlist/generated/app_localizations.dart';

class NowPlaying {
  NowPlaying._();

  static Future<void> show(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (bottomSheetContext) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: BlocProvider(
            create: (context) => NowPlayingPageCubit(),
            child: NowPlayingView(),
          ),
        );
      },
    );
  }
}

class NowPlayingView extends StatefulWidget {
  const NowPlayingView({super.key});

  @override
  State<NowPlayingView> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends State<NowPlayingView>
    with SingleTickerProviderStateMixin {
  NowPlayingPageCubit get _cubit {
    return context.read<NowPlayingPageCubit>();
  }

  final ScrollController _upNextScrollController = ScrollController();
  final ScrollController _lyricsScrollController = ScrollController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _upNextScrollController.dispose();
    _lyricsScrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<NowPlayingPageCubit, NowPlayingPageState>(
      builder: (context, state) {
        return BlocBuilder<SessionCubit, SessionState>(
          builder: (context, sessionState) {
            final lyrics = sessionState.allLyrics.firstWhereOrNull(
              (e) => e.musicId == sessionState.currentMusic?.id,
            );
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 6,
                    width: 64,
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                NowPlayingHeaderTile(
                  sessionState: sessionState,
                  onTapPlay: _cubit.onTapPlay,
                  onTapSkipPrevious: _cubit.onTapSkipPrevious,
                  onTapSkipNext: _cubit.onTapSkipNext,
                  onSeek: (value) {
                    SessionCubit.instance.seek(value);
                  },
                  onSeekStart: (value) {
                    SessionCubit.instance.startSeek();
                  },
                  onSeekEnd: _cubit.onSeekEnd,
                ),
                const SizedBox(height: 16),
                const Divider(
                  indent: 24,
                  endIndent: 24,
                ),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: AppLocalizations.of(context).upNext),
                    Tab(text: AppLocalizations.of(context).lyrics),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Scrollbar(
                        controller: _upNextScrollController,
                        child: ReorderableListView.builder(
                          scrollController: _upNextScrollController,
                          itemCount: sessionState.upNextMusics.length,
                          buildDefaultDragHandles: true,
                          itemBuilder: (context, index) {
                            final music = sessionState.upNextMusics[index];
                            return NowPlayingUpNextTile(
                              key: ValueKey(music),
                              music: music,
                              onSelected: () {
                                _cubit.playUpNext(music);
                              },
                            );
                          },
                          onReorder: (oldIndex, newIndex) {
                            SessionCubit.instance.onReorderUpNext(
                              oldIndex: oldIndex,
                              newIndex: newIndex,
                            );
                          },
                        ),
                      ),
                      Scrollbar(
                        controller: _lyricsScrollController,
                        child: SingleChildScrollView(
                          controller: _lyricsScrollController,
                          padding: EdgeInsets.all(16),
                          child: SafeArea(
                            child: Text(
                              lyrics?.lyrics ?? '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
      listener: _listener,
    );
  }

  void _listener(BuildContext context, NowPlayingPageState state) {
    switch (state.status) {
      case NowPlayingPageStatus.initial:
      case NowPlayingPageStatus.ready:
        break;

      case NowPlayingPageStatus.failure:
        AppAlert.error(context, error: state.error);
        break;
    }
  }
}
