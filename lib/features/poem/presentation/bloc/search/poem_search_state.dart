part of 'poem_search_bloc.dart';

@immutable
sealed class PoemSearchState {}

final class PoemSearchInitial extends PoemSearchState {}

final class PoemSearchLoading extends PoemSearchState {}

final class PoemSearchFailure extends PoemSearchState {
  final String message;

  PoemSearchFailure({required this.message});
}

final class PoemSearchEmpty extends PoemSearchState {}

final class PoemSearchSuccess extends PoemSearchState {
  final PoemDataModel PoemSearchResults;
  final bool hasReachedMax;

  PoemSearchSuccess({
    required this.PoemSearchResults,
    this.hasReachedMax = false,
  });
}
