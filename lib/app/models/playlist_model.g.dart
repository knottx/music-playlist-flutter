// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'] as String?,
      coverAssetPath: json['coverAssetPath'] as String?,
      name: json['name'] as String?,
      author: json['author'] as String?,
      musics: (json['musics'] as List<dynamic>?)
          ?.map((e) => Music.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('coverAssetPath', instance.coverAssetPath);
  writeNotNull('name', instance.name);
  writeNotNull('author', instance.author);
  writeNotNull('musics', instance.musics?.map((e) => e.toJson()).toList());
  return val;
}
