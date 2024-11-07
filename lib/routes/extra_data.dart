import 'package:json_annotation/json_annotation.dart';
import 'package:music_playlist/app/models/playlist_model.dart';

part 'extra_data.g.dart';

@JsonSerializable()
class ExtraData {
  final Playlist? playlist;

  const ExtraData({
    this.playlist,
  });

  factory ExtraData.fromJson(Map<String, dynamic> json) =>
      _$ExtraDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraDataToJson(this);
}
