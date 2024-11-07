import 'package:equatable/equatable.dart';

class Lyrics extends Equatable {
  final String musicId;
  final String lyrics;

  const Lyrics({
    required this.musicId,
    required this.lyrics,
  });

  @override
  List<Object?> get props => [
        musicId,
        lyrics,
      ];
}
