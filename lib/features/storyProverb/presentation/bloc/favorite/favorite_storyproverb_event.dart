part of 'favorite_storyproverb_bloc.dart';

@immutable
sealed class FavoriteStoryProverbEvent {}

final class FavoriteStoryProverbInit extends FavoriteStoryProverbEvent {
  final ProverbStory proverbStory;

  FavoriteStoryProverbInit({required this.proverbStory});
}

final class FavoriteStoryProverbAdd extends FavoriteStoryProverbEvent {
  final String id;

  FavoriteStoryProverbAdd({required this.id});
}

final class FavoriteStoryProverbRemove extends FavoriteStoryProverbEvent {
  final String id;

  FavoriteStoryProverbRemove({required this.id});
}
