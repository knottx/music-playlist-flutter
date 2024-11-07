import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';
import 'package:music_playlist/app/manager/session_state.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class MusicPlayerOverlay extends StatelessWidget {
  final SessionState sessionState;
  final VoidCallback onSelected;

  const MusicPlayerOverlay({
    super.key,
    required this.sessionState,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final playerStatus = sessionState.playerStatus;
    final currentPosition = sessionState.currentPosition;
    final maxDuration = sessionState.maxDuration;

    final progress = (currentPosition?.inMilliseconds ?? 0) /
        (maxDuration?.inMilliseconds ?? 1);

    final currentMusic = sessionState.currentMusic;
    final coverImagePath = currentMusic?.coverImagePath;

    return OutlinedButton(
      onPressed: onSelected,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        padding: EdgeInsets.zero,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  color: theme.colorScheme.surfaceContainerHigh,
                  child: (coverImagePath != null)
                      ? Image.file(
                          File(coverImagePath),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Visibility(
                            visible: playerStatus.isPlaying,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: RiveAnimatedIcon(
                                riveIcon: RiveIcon.sound,
                                color: Theme.of(context).colorScheme.primary,
                                width: 16,
                                height: 16,
                                loopAnimation: true,
                                strokeWidth: 8,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              currentMusic?.trackName ?? '',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        currentMusic?.artist ?? '',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    if (currentMusic != null) {
                      SessionCubit.instance.resumeMusic(currentMusic);
                    }
                  },
                  icon: Icon(sessionState.playerStatus.nowPlayingIconData),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: LinearProgressIndicator(
              value: progress.clamp(0, 1),
              minHeight: 2,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
