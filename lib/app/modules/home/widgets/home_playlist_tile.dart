import 'package:flutter/material.dart';
import 'package:music_playlist/app/constants/player_status.dart';
import 'package:music_playlist/app/models/playlist_model.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class HomePlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final PlayerStatus status;
  final VoidCallback onSelected;
  final VoidCallback onTapPlay;

  const HomePlaylistTile({
    super.key,
    required this.playlist,
    required this.status,
    required this.onSelected,
    required this.onTapPlay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final coverAssetPath = playlist.coverAssetPath;
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
            height: 64,
            width: 64,
            color: theme.colorScheme.surfaceContainerHigh,
            child: (coverAssetPath != null)
                ? Image.asset(
                    coverAssetPath,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  playlist.name ?? '',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: status.isStopped ? null : theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 4),
                Text(
                  playlist.author ?? '',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Visibility(
            visible: status.isPlaying,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: RiveAnimatedIcon(
                riveIcon: RiveIcon.sound,
                color: Theme.of(context).colorScheme.primary,
                width: 24,
                height: 24,
                loopAnimation: true,
                strokeWidth: 8,
              ),
            ),
          ),
          IconButton(
            onPressed: onTapPlay,
            icon: Icon(
              status.nowPlayingIconData,
            ),
          ),
        ],
      ),
    );
  }
}
