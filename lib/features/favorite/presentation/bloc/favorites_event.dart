part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {}

final class FavoriteFetchEvent extends FavoritesEvent {}
