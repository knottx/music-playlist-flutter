import 'package:audio_service/audio_service.dart';
import 'package:music_playlist/app/manager/session_cubit.dart';

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

  @override
  Future<void> seek(Duration position) {
    SessionCubit.instance.confirmSeekToPosition(position);
    return super.seek(position);
  }
}
