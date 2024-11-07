import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_playlist/app/manager/session_state.dart';
import 'package:music_playlist/app/utils/app_utils.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class NowPlayingHeaderTile extends StatelessWidget {
  final SessionState sessionState;
  final VoidCallback onTapPlay;
  final VoidCallback onTapSkipPrevious;
  final VoidCallback onTapSkipNext;
  final void Function(double) onSeek;
  final void Function(double) onSeekStart;
  final void Function(double) onSeekEnd;

  const NowPlayingHeaderTile({
    super.key,
    required this.sessionState,
    required this.onTapPlay,
    required this.onTapSkipPrevious,
    required this.onTapSkipNext,
    required this.onSeek,
    required this.onSeekStart,
    required this.onSeekEnd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playerStatus = sessionState.playerStatus;
    final currentMusic = sessionState.currentMusic;
    final coverImagePath = currentMusic?.coverImagePath;

    final currentPosition = sessionState.currentPosition;
    final maxDuration = sessionState.maxDuration;

    final progress = (currentPosition?.inMilliseconds ?? 0) /
        (maxDuration?.inMilliseconds ?? 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            children: [
              Container(
                height: 64,
                width: 64,
                color: theme.colorScheme.surfaceContainerHigh,
                child: (coverImagePath != null)
                    ? Image.file(
                        File(coverImagePath),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
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
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: playerStatus.isStopped
                                  ? null
                                  : theme.colorScheme.primary,
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
                      style: theme.textTheme.labelSmall,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Positioned(
              left: 24,
              right: 24,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentPosition != null
                        ? AppUtils.formatDuration(currentPosition)
                        : '',
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    (currentPosition != null && maxDuration != null)
                        ? AppUtils.formatDuration(currentPosition - maxDuration)
                        : '',
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                  trackHeight: 3,
                ),
                child: Slider(
                  value: progress.clamp(0, 1),
                  onChanged: onSeek,
                  onChangeStart: onSeekStart,
                  onChangeEnd: onSeekEnd,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onTapSkipPrevious,
              icon: Icon(Icons.skip_previous),
            ),
            const SizedBox(width: 32),
            IconButton.filled(
              onPressed: onTapPlay,
              icon: Icon(
                playerStatus.nowPlayingIconData,
                size: 32,
              ),
            ),
            const SizedBox(width: 32),
            IconButton(
              onPressed: onTapSkipNext,
              icon: Icon(Icons.skip_next),
            ),
          ],
        ),
      ],
    );
  }
}
