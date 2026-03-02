part of 'favorite_storyproverb_bloc.dart';

@immutable
sealed class FavoriteStoryProverbState {}

final class FavoriteStoryProverbInitial extends FavoriteStoryProverbState {}

final class FavoriteStoryProverbLoading extends FavoriteStoryProverbState {}

final class FavoriteStoryProverbFailure extends FavoriteStoryProverbState {
  final String message;

  FavoriteStoryProverbFailure({required this.message});
}

final class FavoriteStoryProverbSuccess extends FavoriteStoryProverbState {
  final ProverbStory proverbStory;

 FavoriteStoryProverbSuccess({required this.proverbStory});
}
