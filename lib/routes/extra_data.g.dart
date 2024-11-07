// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraData _$ExtraDataFromJson(Map<String, dynamic> json) => ExtraData(
      playlist: json['playlist'] == null
          ? null
          : Playlist.fromJson(json['playlist'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtraDataToJson(ExtraData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('playlist', instance.playlist?.toJson());
  return val;
}
