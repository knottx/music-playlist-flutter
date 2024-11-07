import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_playlist/app/models/music_model.dart';

class NowPlayingUpNextTile extends StatelessWidget {
  final Music music;
  final VoidCallback onSelected;

  const NowPlayingUpNextTile({
    super.key,
    required this.music,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coverImagePath = music.coverImagePath;
    return Stack(
      children: [
        OutlinedButton(
          onPressed: onSelected,
          style: OutlinedButton.styleFrom(
            shape: const BeveledRectangleBorder(),
            side: BorderSide.none,
            padding: EdgeInsets.fromLTRB(16, 8, 64, 8),
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
                    Text(
                      music.trackName ?? '',
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
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
        ),
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            width: 64,
            child: Icon(
              Icons.menu,
            ),
          ),
        ),
      ],
    );
  }
}
