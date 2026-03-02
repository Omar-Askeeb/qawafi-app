part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteFailure extends FavoriteState {
  final String message;

  FavoriteFailure({required this.message});
}

final class FavoriteSuccess extends FavoriteState {
  final Poem poem;

  FavoriteSuccess({required this.poem});
}
