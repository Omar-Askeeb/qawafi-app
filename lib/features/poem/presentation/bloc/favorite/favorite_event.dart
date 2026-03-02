part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class FavoriteInit extends FavoriteEvent {
  final Poem poem;

  FavoriteInit({required this.poem});
}

final class FavoriteAdd extends FavoriteEvent {
  final String poemId;

  FavoriteAdd({required this.poemId});
}

final class FavoriteRemove extends FavoriteEvent {
  final String poemId;

  FavoriteRemove({required this.poemId});
}
