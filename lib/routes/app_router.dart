import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_playlist/app/modules/home/home_page.dart';
import 'package:music_playlist/app/modules/playlist/playlist_page.dart';
import 'package:music_playlist/routes/extra_codec.dart';
import 'package:music_playlist/routes/extra_data.dart';

class AppRouter {
  AppRouter._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    navigatorKey: navigatorKey,
    extraCodec: const ExtraCodec(),
    initialLocation: '/',
    routes: [
      /// Home
      /// '/'
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          /// Playlist
          /// '/playlist'
          GoRoute(
            path: 'playlist',
            builder: (context, state) {
              final extraData = state.extra as ExtraData?;
              return PlaylistPage(
                playlist: extraData?.playlist,
              );
            },
          ),
        ],
      ),
    ],
  );
}
