part of 'playerStoryProverb_bloc.dart';

abstract class PlayerStoryProverbState {}

class PlayerStoryProverbInitial extends PlayerStoryProverbState {}

class PlayerStoryProverbLoading extends PlayerStoryProverbState {}

class PlayerStoryProverbLoaded extends PlayerStoryProverbState {
  final ProverbStory currentStoryProverb;
  // final List<ProverbStory> storyProverbs;
  final bool isPlaying;
  final Duration currentPosition;

  PlayerStoryProverbLoaded({
    required this.currentStoryProverb,
    // required this.storyProverbs,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
  });
}

class PlayerStoryProverbFailure extends PlayerStoryProverbState {
  final String message;

  PlayerStoryProverbFailure({required this.message});
}

class PlayerStoryProverbFavoriteUpdated extends PlayerStoryProverbState {
  final ProverbStory updatedStoryProverb;

  PlayerStoryProverbFavoriteUpdated({required this.updatedStoryProverb});
}
