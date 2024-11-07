import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_playlist/app/models/music_model.dart';

part 'playlist_model.g.dart';

@JsonSerializable()
class Playlist extends Equatable {
  final String? id;
  final String? coverAssetPath;
  final String? name;
  final String? author;
  final List<Music>? musics;

  const Playlist({
    required this.id,
    required this.coverAssetPath,
    required this.name,
    required this.author,
    required this.musics,
  });

  @override
  List<Object?> get props => [
        id,
        coverAssetPath,
        name,
        author,
        musics,
      ];

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
