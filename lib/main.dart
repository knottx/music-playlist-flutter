import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/app/global_widgets/music_player_overlay.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/manager/session_state.dart';
import 'package:music_playlist/app/modules/now_playing/now_playing_page.dart';
import 'package:music_playlist/app_theme.dart';
import 'package:music_playlist/generated/app_localizations.dart';
import 'package:music_playlist/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AudioPlayerHandler.initialize();

  await SessionCubit.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit.instance,
      child: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, sessionState) {
          return MaterialApp.router(
            title: 'Music Playlist',
            themeMode: ThemeMode.dark,
            theme: const AppTheme().lightMediumContrast(),
            darkTheme: const AppTheme().darkMediumContrast(),
            routerConfig: AppRouter.router,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
            builder: (context, child) {
              return Stack(
                children: [
                  child!,
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Visibility(
                      visible: sessionState.currentMusic != null &&
                          !sessionState.showBottomSheetNowPlaying,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Material(
                            type: MaterialType.transparency,
                            child: MusicPlayerOverlay(
                              sessionState: sessionState,
                              onSelected: () async {
                                SessionCubit.instance
                                    .setShowBottomSheetNowPlaying(true);
                                await NowPlaying.show(
                                  AppRouter.navigatorKey.currentContext!,
                                );
                                SessionCubit.instance
                                    .setShowBottomSheetNowPlaying(false);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
