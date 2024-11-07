import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_playlist/app/constants/player_status.dart';
import 'package:music_playlist/app/models/music_model.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class PlaylistMusicTile extends StatelessWidget {
  final Music music;
  final PlayerStatus status;
  final VoidCallback onSelected;

  const PlaylistMusicTile({
    super.key,
    required this.music,
    required this.status,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coverImagePath = music.coverImagePath;

    return OutlinedButton(
      onPressed: onSelected,
      style: OutlinedButton.styleFrom(
        shape: const BeveledRectangleBorder(),
        side: BorderSide.none,
        backgroundColor:
            status.isStopped ? null : theme.colorScheme.surfaceContainer,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
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
                      visible: status.isPlaying,
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
                        music.trackName ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: status.isStopped
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
                  music.artist ?? '',
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
    );
  }
}
