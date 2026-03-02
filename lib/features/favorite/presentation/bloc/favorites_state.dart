part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesFailure extends FavoritesState {
  final String message;

  FavoritesFailure({required this.message});
}

final class FavoritesSuccess extends FavoritesState {
  final List<PoemModel> poems;
  final List<QuatrainModel> quatrains;
  final List<ProverbStoryModel> proverbs;

  FavoritesSuccess({
    required this.poems,
    required this.quatrains,
    required this.proverbs,
  });
}
