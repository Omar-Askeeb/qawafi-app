part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent {}

class LoadAudio extends AudioEvent {
  final String url;
  final Map<String, String>? headers;

  LoadAudio({required this.url, this.headers});
}

final class PlayAudio extends AudioEvent {}

final class PauseAudio extends AudioEvent {}

final class SeekAudio extends AudioEvent {
  final Duration position;

  SeekAudio({required this.position});
}

final class SkipForward extends AudioEvent {
  final Duration skipDuration;

  SkipForward({this.skipDuration = const Duration(seconds: 10)});
}

final class SkipBackward extends AudioEvent {
  final Duration skipDuration;

  SkipBackward({this.skipDuration = const Duration(seconds: 10)});
}

final class AudioDurationChanged extends AudioEvent {
  final Duration duration;

  AudioDurationChanged(this.duration);
}

final class AudioPositionChanged extends AudioEvent {
  final Duration position;

  AudioPositionChanged(this.position);
}

final class AudioPlayingChanged extends AudioEvent {
  final bool isPlaying;

  AudioPlayingChanged(this.isPlaying);
}

final class AudioDispose extends AudioEvent {}
