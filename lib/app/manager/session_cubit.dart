import 'dart:io';

import 'package:audio_metadata_extractor/audio_metadata_extractor.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/app/constants/player_status.dart';
import 'package:music_playlist/app/manager/session_state.dart';
import 'package:music_playlist/app/models/lyrics_model.dart';
import 'package:music_playlist/app/models/music_model.dart';
import 'package:music_playlist/app/models/playlist_model.dart';
import 'package:music_playlist/generated/assets.gen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class SessionCubit extends Cubit<SessionState> {
  static late final SessionCubit instance;
  static bool _isInitialized = false;

  final _player = AudioPlayer();

  SessionCubit._() : super(const SessionState()) {
    _player.onPlayerStateChanged.listen((playerState) async {
      bool playing = false;
      switch (playerState) {
        case PlayerState.completed:
          playNext();
          break;

        case PlayerState.stopped:
          emit(
            state.copyWith(
              playerStatus: PlayerStatus.stopped,
              onSeek: false,
            ),
          );
          break;

        case PlayerState.disposed:
          emit(
            state.copyWith(
              playerStatus: PlayerStatus.stopped,
              onSeek: false,
            ),
          );
          break;

        case PlayerState.playing:
          emit(
            state.copyWith(
              playerStatus: PlayerStatus.playing,
              onSeek: false,
            ),
          );
          playing = true;
          break;

        case PlayerState.paused:
          emit(
            state.copyWith(
              playerStatus: PlayerStatus.paused,
              onSeek: false,
            ),
          );
          break;
      }
      final audioPlayerHandler = AudioPlayerHandler.instance;
      audioPlayerHandler.playbackState.add(
        audioPlayerHandler.playbackState.value.copyWith(
          controls: [
            MediaControl.skipToPrevious,
            MediaControl.pause,
            MediaControl.play,
            MediaControl.skipToNext,
          ],
          processingState: AudioProcessingState.ready,
          playing: playing,
        ),
      );
    });

    _player.onDurationChanged.listen((Duration duration) {
      emit(state.copyWith(maxDuration: duration));
    });

    _player.onPositionChanged.listen((duration) async {
      if (!state.onSeek) {
        emit(state.copyWith(currentPosition: duration));

        final audioPlayerHandler = AudioPlayerHandler.instance;
        audioPlayerHandler.playbackState.add(
          audioPlayerHandler.playbackState.value.copyWith(
            updatePosition: duration,
          ),
        );
      }
    });
  }

  static Future<void> initialize() async {
    if (_isInitialized) return;

    instance = SessionCubit._();

    await instance._loadSession();

    _isInitialized = true;
    return;
  }

  Future<void> _loadSession() async {
    final tempDir = await getTemporaryDirectory();
    final result = await Future.wait(
      Assets.musics.values
          .map((e) => _loadAssetAsFile(tempPath: tempDir.path, assetPath: e)),
    );

    final chunkSize = (result.length / 3.0).ceil();

    List<Music> listA = [];
    List<Music> listB = [];
    List<Music> listC = [];

    result.forEach((e) {
      if (listA.length < chunkSize) {
        listA.add(e);
      } else if (listB.length < chunkSize) {
        listB.add(e);
      } else if (listC.length < chunkSize) {
        listC.add(e);
      }
    });

    emit(
      state.copyWith(
        playlists: [
          Playlist(
            id: Uuid().v4(),
            coverAssetPath: Assets.images.coverA.path,
            name: 'A Hits',
            author: 'knottx',
            musics: listA,
          ),
          Playlist(
            id: Uuid().v4(),
            coverAssetPath: Assets.images.coverB.path,
            name: 'B Mix',
            author: 'knottx',
            musics: listB,
          ),
          Playlist(
            id: Uuid().v4(),
            coverAssetPath: Assets.images.coverC.path,
            name: 'C Vibe',
            author: 'knottx',
            musics: listC,
          ),
        ].where((e) => e.musics?.isNotEmpty ?? false).toList(),
      ),
    );
    return;
  }

  Future<Music> _loadAssetAsFile({
    required String tempPath,
    required String assetPath,
  }) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();

    final fileName = assetPath.split('/').last;
    final filePath = '$tempPath/$fileName.mp3';
    final file = File(filePath);

    await file.writeAsBytes(bytes, flush: true);

    final metadata = await AudioMetadata.extract(file);
    final coverData = metadata?.coverData;

    final coverImageData =
        (coverData != null) ? Uint8List.fromList(coverData) : null;

    String? coverImagePath;
    if (coverImageData != null) {
      coverImagePath = '$tempPath/${fileName}_cover.png';
      final coverFile = File(coverImagePath);
      await coverFile.writeAsBytes(coverImageData, flush: true);
    }

    return Music(
      id: const Uuid().v4(),
      filePath: filePath,
      coverImagePath: coverImagePath,
      trackName: metadata?.trackName,
      artist: metadata?.firstArtists,
      duration: metadata?.duration,
    );
  }

  Future<void> playPlaylist(Playlist playlist) async {
    try {
      if ((playlist.musics ?? []).contains(state.currentMusic)) {
        switch (state.playerStatus) {
          case PlayerStatus.stopped:
            final music = playlist.musics?.firstOrNull;
            if (music != null) {
              await resumeMusic(music);
            }
            break;

          case PlayerStatus.playing:
            await pause();
            break;

          case PlayerStatus.paused:
            await resume();
            break;
        }
      } else {
        final music = playlist.musics?.firstOrNull;
        if (music == null) return;

        await playNewMusic(music);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> resumeMusic(Music music) async {
    try {
      if (music == state.currentMusic) {
        switch (state.playerStatus) {
          case PlayerStatus.stopped:
            await _playMusic(music);
            break;

          case PlayerStatus.playing:
            await pause();
            break;

          case PlayerStatus.paused:
            await resume();
            break;
        }
      } else {
        await playNewMusic(music);
      }
    } catch (error) {
      rethrow;
    }
  }

  void generateUpNext() {
    final currentMusic = state.currentMusic;
    if (currentMusic == null) return;

    final playlist = state.playlists.firstWhereOrNull(
      (e) => e.musics?.contains(currentMusic) ?? false,
    );

    final musics = playlist?.musics ?? [];
    final index = musics.indexOf(currentMusic);

    emit(
      state.copyWith(
        upNextMusics: (index >= 0)
            ? [
                ...musics.sublist(index + 1),
                ...musics.sublist(0, index),
              ]
            : musics,
        historyMusics: [],
      ),
    );
  }

  PlayerStatus playlistStatus(Playlist playlist) {
    if ((playlist.musics ?? []).contains(state.currentMusic)) {
      return state.playerStatus;
    } else {
      return PlayerStatus.stopped;
    }
  }

  PlayerStatus musicStatus(Music music) {
    if (music == state.currentMusic) {
      return state.playerStatus;
    } else {
      return PlayerStatus.stopped;
    }
  }

  void setShowBottomSheetNowPlaying(bool value) {
    emit(state.copyWith(showBottomSheetNowPlaying: value));
  }

  void startSeek() {
    emit(state.copyWith(onSeek: true));
  }

  void seek(double value) async {
    if (state.playerStatus.isStopped) return;
    if (!state.onSeek) return;
    final maxSeconds = state.maxDuration?.inSeconds;
    if (maxSeconds != null) {
      final position = (maxSeconds * value.clamp(0, 1)).toInt();
      emit(state.copyWith(currentPosition: Duration(seconds: position)));
    }
  }

  Future<void> confirmSeek(double value) async {
    if (!state.onSeek) return;
    try {
      final maxSeconds = state.maxDuration?.inSeconds;
      if (maxSeconds != null) {
        final position = (maxSeconds * value.clamp(0, 1)).toInt();
        await _player.seek(Duration(seconds: position));
        emit(state.copyWith(onSeek: false));
      }
    } catch (error) {
      rethrow;
    }
  }

  void onReorderUpNext({
    required int oldIndex,
    required int newIndex,
  }) {
    if (newIndex > oldIndex) newIndex -= 1;
    List<Music> upNextMusics = [];
    upNextMusics.addAll(state.upNextMusics);
    final music = upNextMusics.removeAt(oldIndex);
    upNextMusics.insert(newIndex, music);
    emit(state.copyWith(upNextMusics: upNextMusics));
  }

  Future<void> playPrevious() async {
    try {
      List<Music> historyMusics = [];
      historyMusics.addAll(state.historyMusics);
      if (historyMusics.isNotEmpty) {
        final music = historyMusics.removeAt(0);

        List<Music> upNextMusics = [];
        upNextMusics.addAll(state.upNextMusics);
        upNextMusics.removeWhere((e) => e == music);
        final currentMusic = state.currentMusic;
        if (currentMusic != null) {
          upNextMusics.insert(0, currentMusic);
        }

        emit(
          state.copyWith(
            historyMusics: historyMusics,
            upNextMusics: upNextMusics,
            currentMusic: music,
          ),
        );

        await _playMusic(music);
      } else {
        final music = state.upNextMusics.lastOrNull;
        if (music != null) {
          await playNewMusic(music);
        }
      }
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> playNext() async {
    try {
      List<Music> upNextMusics = [];
      upNextMusics.addAll(state.upNextMusics);

      final music = upNextMusics.removeAt(0);

      await stop();

      final currentMusic = state.currentMusic;
      if (currentMusic != null) {
        List<Music> historyMusics = [];
        historyMusics.addAll(state.historyMusics);
        historyMusics.insert(0, currentMusic);
        emit(state.copyWith(historyMusics: historyMusics));

        upNextMusics.add(currentMusic);
      }

      emit(
        state.copyWith(
          upNextMusics: upNextMusics,
          currentMusic: music,
        ),
      );

      await _playMusic(music);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> playUpNext(Music music) async {
    try {
      List<Music> upNextMusics = [];
      upNextMusics.addAll(state.upNextMusics);

      final index = upNextMusics.indexOf(music);

      if (index >= 0) {
        upNextMusics = [
          ...upNextMusics.sublist(index + 1),
          ...upNextMusics.sublist(0, index),
        ];
      }

      await stop();

      final currentMusic = state.currentMusic;
      if (currentMusic != null) {
        List<Music> historyMusics = [];
        historyMusics.addAll(state.historyMusics);
        historyMusics.insert(0, currentMusic);
        emit(state.copyWith(historyMusics: historyMusics));

        upNextMusics.add(currentMusic);
      }

      emit(
        state.copyWith(
          upNextMusics: upNextMusics,
          currentMusic: music,
        ),
      );

      await _playMusic(music);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> stop() {
    return _player.stop();
  }

  Future<void> pause() {
    return _player.pause();
  }

  Future<void> resume() {
    return _player.resume();
  }

  Future<void> playNewMusic(Music music) async {
    try {
      await stop();
      emit(state.copyWith(currentMusic: music));
      await _playMusic(music);
      generateUpNext();
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _playMusic(Music music) async {
    final filePath = music.filePath;
    if (filePath == null) return;

    try {
      AudioPlayerHandler.instance.mediaItem.add(music.mediaItem());

      await _player.play(DeviceFileSource(filePath));

      _getLyrics(music);
      return;
    } catch (error) {
      rethrow;
    }
  }

  void _getLyrics(Music music) async {
    final musicId = music.id;
    if (musicId == null) return;

    List<Lyrics> allLyrics = [];
    allLyrics.addAll(state.allLyrics);
    final lyrics = allLyrics.firstWhereOrNull(
      (e) => e.musicId == musicId,
    );
    if (lyrics != null) return;

    final artist = music.artist;
    final trackName = music.trackName;
    if (artist == null || trackName == null) return;

    try {
      final result = await Dio().getUri(
        Uri.parse('https://api.lyrics.ovh/v1/$artist/$trackName'),
      );
      if (result.data != null && result.data.containsKey('lyrics')) {
        final newLyrics = result.data['lyrics'];
        allLyrics.add(
          Lyrics(
            musicId: musicId,
            lyrics: newLyrics,
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(allLyrics: allLyrics));
    }
    allLyrics.add(
      Lyrics(
        musicId: musicId,
        lyrics: 'No lyrics provided.',
      ),
    );
    emit(state.copyWith(allLyrics: allLyrics));
  }
}

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static late final AudioPlayerHandler instance;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    instance = await AudioService.init<AudioPlayerHandler>(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId:
            'com.example.music_playlist.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );

    _isInitialized = true;
    return;
  }

  @override
  Future<void> play() async {
    await SessionCubit.instance.resume();
    return super.play();
  }

  @override
  Future<void> pause() async {
    await SessionCubit.instance.pause();
    return super.pause();
  }

  @override
  Future<void> skipToPrevious() {
    SessionCubit.instance.playPrevious();
    return super.skipToNext();
  }

  @override
  Future<void> skipToNext() {
    SessionCubit.instance.playNext();
    return super.skipToNext();
  }
}
