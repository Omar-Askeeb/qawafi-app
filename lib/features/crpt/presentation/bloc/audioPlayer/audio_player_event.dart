part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerEvent {}

class LoadAudio extends AudioPlayerEvent {
  final String url;
  final int index;
  LoadAudio({required this.url,required this.index,});
}

final class PlayAudio extends AudioPlayerEvent {}

final class PauseAudio extends AudioPlayerEvent {}

final class SeekAudio extends AudioPlayerEvent {
  final Duration position;

  SeekAudio({required this.position});
}


final class AudioDurationChanged extends AudioPlayerEvent {
  final Duration duration;

  AudioDurationChanged(this.duration);
}

final class AudioPositionChanged extends AudioPlayerEvent {
  final Duration position;

  AudioPositionChanged(this.position);
}

final class AudioPlayingChanged extends AudioPlayerEvent {
  final bool isPlaying;

  AudioPlayingChanged(this.isPlaying);
}

final class AudioDispose extends AudioPlayerEvent {}

final class PositionUpdated extends AudioPlayerEvent {
  final Duration position;

  PositionUpdated({required this.position});
}
