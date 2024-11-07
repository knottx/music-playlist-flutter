import 'package:equatable/equatable.dart';

enum NowPlayingPageStatus {
  initial,
  ready,
  failure,
  ;
}

class NowPlayingPageState extends Equatable {
  final NowPlayingPageStatus status;
  final Object? error;

  const NowPlayingPageState({
    this.status = NowPlayingPageStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        error,
      ];

  NowPlayingPageState copyWith({
    NowPlayingPageStatus? status,
    Object? error,
  }) {
    return NowPlayingPageState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  NowPlayingPageState ready() {
    return copyWith(
      status: NowPlayingPageStatus.ready,
    );
  }

  NowPlayingPageState failure(
    Object error,
  ) {
    return copyWith(
      status: NowPlayingPageStatus.failure,
      error: error,
    );
  }
}
