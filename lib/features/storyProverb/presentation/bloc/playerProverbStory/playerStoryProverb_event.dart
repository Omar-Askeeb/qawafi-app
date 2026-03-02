part of 'playerStoryProverb_bloc.dart';

abstract class PlayerStoryProverbEvent {}



class UpdateStoryProverbFavoriteEvent extends PlayerStoryProverbEvent {
  final String storyProverbId;
  final bool isFavorite;

  UpdateStoryProverbFavoriteEvent({
    required this.storyProverbId,
    required this.isFavorite,
  });
}

class PlayPauseEvent extends PlayerStoryProverbEvent {}
class PauseEvent extends PlayerStoryProverbEvent {}
class ResetPositionEvent extends PlayerStoryProverbEvent {}



class UpdateProgressEvent extends PlayerStoryProverbEvent {
  final Duration position;

  UpdateProgressEvent(this.position);
}

class SelectStoryProverbEvent extends PlayerStoryProverbEvent {
  final String storyProverbId;
  final bool isPlay;

  SelectStoryProverbEvent({required this.storyProverbId, this.isPlay = true});
}


