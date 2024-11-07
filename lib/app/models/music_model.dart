import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'music_model.g.dart';

@JsonSerializable()
class Music extends Equatable {
  final String? id;
  final String? filePath;
  final String? coverImagePath;
  final String? trackName;
  final String? artist;
  final Duration? duration;

  const Music({
    required this.id,
    required this.filePath,
    required this.coverImagePath,
    required this.trackName,
    required this.artist,
    required this.duration,
  });

  @override
  List<Object?> get props => [
        id,
        filePath,
        coverImagePath,
        trackName,
        artist,
        duration,
      ];

  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);

  Map<String, dynamic> toJson() => _$MusicToJson(this);

  MediaItem mediaItem() {
    return MediaItem(
      id: id ?? Uuid().v4(),
      title: trackName ?? '',
      artist: artist,
      artUri: (coverImagePath != null) ? Uri.file(coverImagePath!) : null,
      duration: duration,
    );
  }
}
