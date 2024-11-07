import 'package:equatable/equatable.dart';

enum HomePageStatus {
  initial,
  ready,
  failure,
  ;
}

class HomePageState extends Equatable {
  final HomePageStatus status;
  final Object? error;

  const HomePageState({
    this.status = HomePageStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        error,
      ];

  HomePageState copyWith({
    HomePageStatus? status,
    Object? error,
  }) {
    return HomePageState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  HomePageState ready() {
    return copyWith(
      status: HomePageStatus.ready,
    );
  }

  HomePageState failure(
    Object error,
  ) {
    return copyWith(
      status: HomePageStatus.failure,
      error: error,
    );
  }
}
