// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Music _$MusicFromJson(Map<String, dynamic> json) => Music(
      id: json['id'] as String?,
      filePath: json['filePath'] as String?,
      coverImagePath: json['coverImagePath'] as String?,
      trackName: json['trackName'] as String?,
      artist: json['artist'] as String?,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$MusicToJson(Music instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('filePath', instance.filePath);
  writeNotNull('coverImagePath', instance.coverImagePath);
  writeNotNull('trackName', instance.trackName);
  writeNotNull('artist', instance.artist);
  writeNotNull('duration', instance.duration?.inMicroseconds);
  return val;
}
