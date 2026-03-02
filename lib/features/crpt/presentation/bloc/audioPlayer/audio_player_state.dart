part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerState {}

final class AudioInitial extends AudioPlayerState {}

final class AudioLoading extends AudioPlayerState {}

final class AudioLoaded extends AudioPlayerState {
  //final Duration totalDuration;
  final Duration currentPosition;
  final bool isPlaying;
  final Duration totalDuration;
  final int playingIndex;

  AudioLoaded({
    // required this.totalDuration,
    required this.currentPosition,
    required this.isPlaying,
    required this.totalDuration,
    required this.playingIndex,
  });
    
}

final class AudioError extends AudioPlayerState {
  final String message;

  AudioError(this.message);
}
