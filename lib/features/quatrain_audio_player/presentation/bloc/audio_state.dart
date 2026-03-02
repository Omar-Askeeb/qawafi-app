part of 'audio_bloc.dart';

@immutable
sealed class AudioState {}

final class AudioInitial extends AudioState {}

final class AudioLoading extends AudioState {}

final class AudioLoaded extends AudioState {
  final Duration totalDuration;
  final Duration currentPosition;
  final bool isPlaying;

  AudioLoaded({
    required this.totalDuration,
    required this.currentPosition,
    required this.isPlaying,
  });
}

final class AudioError extends AudioState {
  final String message;

  AudioError(this.message);
}
