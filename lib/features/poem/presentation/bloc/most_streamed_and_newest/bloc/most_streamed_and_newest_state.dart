part of 'most_streamed_and_newest_bloc.dart';

@immutable
sealed class MostStreamedAndNewestState {}

class MostStreamedAndNewestInitial extends MostStreamedAndNewestState {}

class MostStreamedAndNewestLoading extends MostStreamedAndNewestState {}

class MostStreamedAndNewestFailure extends MostStreamedAndNewestState {
  final String message;

  MostStreamedAndNewestFailure({required this.message});
}

class MostStreamedAndNewestSuccess extends MostStreamedAndNewestState {
  final PoemDataModel mostStreamed;
  final PoemDataModel newest;

  MostStreamedAndNewestSuccess({
    required this.mostStreamed,
    required this.newest,
  });
}
