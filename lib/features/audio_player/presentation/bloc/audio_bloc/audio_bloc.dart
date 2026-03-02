import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

import '../../../../../core/localStorage/loacal_storage.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer audioPlayer;
  final LocalStorage localStorage;

  AudioBloc(this.audioPlayer, this.localStorage) : super(AudioInitial()) {
    on<LoadAudio>(_onLoadAudio);
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<SeekAudio>(_onSeekAudio);
    on<SkipForward>(_onSkipForward);
    on<SkipBackward>(_onSkipBackward);
    on<AudioDurationChanged>(_onAudioDurationChanged);
    on<AudioPositionChanged>(_onAudioPositionChanged);
    on<AudioPlayingChanged>(_onAudioPlayingChanged);
    on<AudioDispose>(_onAudioDispose);

    audioPlayer.positionStream.listen((position) {
      add(AudioPositionChanged(position));
    });

    audioPlayer.durationStream.listen((duration) {
      add(AudioDurationChanged(duration ?? Duration.zero));
    });

    audioPlayer.playingStream.listen((isPlaying) {
      add(AudioPlayingChanged(isPlaying));
    });
  }

  Future<void> _onLoadAudio(LoadAudio event, Emitter<AudioState> emit) async {
    emit(AudioLoading());
    try {
      await audioPlayer.setUrl(event.url, headers: event.headers);
      log(event.headers.toString());
      final duration = await audioPlayer.load();
      if (duration != null) {
        emit(AudioLoaded(
          totalDuration: duration,
          currentPosition: Duration.zero,
          isPlaying: false,
        ));
      } else {
        emit(AudioError('Failed to load audio'));
      }
    } on PlayerException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.runtimeType.toString());
      emit(AudioError(e.toString()));
    }
  }

  // Other event handlers...

  // Future<void> _onLoadAudio(LoadAudio event, Emitter<AudioState> emit) async {
  //   emit(AudioLoading());
  //   try {
  //     await _audioPlayer.setUrl(event.url, headers: {
  //       'Authorization': (await localStorage.accessToken),
  //     });

  //     final totalDuration = _audioPlayer.duration ?? Duration.zero;
  //     emit(AudioLoaded(
  //       totalDuration: totalDuration,
  //       currentPosition: Duration.zero,
  //       isPlaying: false,
  //     ));
  //   } catch (e) {
  //     emit(AudioError('Failed to load audio'));
  //   }
  // }

  void _onPlayAudio(PlayAudio event, Emitter<AudioState> emit) async {
    await audioPlayer.play();
    emit(_getCurrentState());
  }

  void _onPauseAudio(PauseAudio event, Emitter<AudioState> emit) async {
    await audioPlayer.pause();
    emit(_getCurrentState());
  }

  void _onSeekAudio(SeekAudio event, Emitter<AudioState> emit) async {
    await audioPlayer.seek(event.position);
    emit(_getCurrentState());
  }

  void _onSkipForward(SkipForward event, Emitter<AudioState> emit) async {
    final currentPosition = audioPlayer.position;
    final newPosition = currentPosition + event.skipDuration;
    await audioPlayer.seek(
        newPosition.inSeconds > audioPlayer.duration!.inSeconds
            ? audioPlayer.duration!
            : newPosition);
    emit(_getCurrentState());
  }

  void _onSkipBackward(SkipBackward event, Emitter<AudioState> emit) async {
    final currentPosition = audioPlayer.position;
    final newPosition = currentPosition - event.skipDuration;
    await audioPlayer
        .seek(newPosition.inSeconds < 0 ? Duration(seconds: 0) : newPosition);
    emit(_getCurrentState());
  }

  void _onAudioDurationChanged(
      AudioDurationChanged event, Emitter<AudioState> emit) {
    emit(_getCurrentState());
  }

  void _onAudioPositionChanged(
      AudioPositionChanged event, Emitter<AudioState> emit) {
    emit(_getCurrentState());
  }

  void _onAudioPlayingChanged(
      AudioPlayingChanged event, Emitter<AudioState> emit) {
    emit(_getCurrentState());
  }

  AudioLoaded _getCurrentState() {
    return AudioLoaded(
      totalDuration: audioPlayer.duration ?? Duration.zero,
      currentPosition: audioPlayer.position,
      isPlaying: audioPlayer.playing,
    );
  }

  _onAudioDispose(event, emit) async {
    await audioPlayer.pause();
    emit(_getCurrentState());
    audioPlayer.dispose();
    close();
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
