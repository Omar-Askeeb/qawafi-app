part of 'list_story_proverb_bloc.dart';


abstract class ListStoryProverbState {}

class ListStoryProverbInitial extends ListStoryProverbState {}

class ListStoryProverbLoading extends ListStoryProverbState {}

class ListStoryProverbLoaded extends ListStoryProverbState {
  final ProverbStory currentStoryProverb;
  final List<ProverbStory> storyProverbs;
  final bool isPlaying;
  final Duration currentPosition;

  ListStoryProverbLoaded({
    required this.currentStoryProverb,
    required this.storyProverbs,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
  });
}



class ListStoryProverbFailure extends ListStoryProverbState {
  final String message;

  ListStoryProverbFailure({required this.message});
}

class ListStoryProverbFavoriteUpdated extends ListStoryProverbState {
  final ProverbStory updatedStoryProverb;

  ListStoryProverbFavoriteUpdated({required this.updatedStoryProverb});
}
