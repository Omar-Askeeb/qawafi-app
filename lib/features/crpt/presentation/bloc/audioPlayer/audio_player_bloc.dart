import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int index = -1;
  bool isLoading = false;

  AudioPlayerBloc(/*, this.localStorage*/) : super(AudioInitial()) {
    on<LoadAudio>(_onLoadAudio);
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<SeekAudio>(_onSeekAudio);
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

  Future<void> _onLoadAudio(
      LoadAudio event, Emitter<AudioPlayerState> emit) async {
    index = event.index;
    isLoading = true;
    emit(AudioLoading());
    try {
      log('urllll CRPT Audui' + event.url);
      await audioPlayer.setUrl(event.url /*, headers: event.headers*/);
      //   log(event.headers.toString());
      final duration = await audioPlayer.load();
      index = event.index;
      if (duration != null) {
        isLoading=false;
        emit(AudioLoaded(
          totalDuration: duration,
          currentPosition: Duration.zero,
          playingIndex: event.index,
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

  void _onPlayAudio(PlayAudio event, Emitter<AudioPlayerState> emit) async {
    await audioPlayer.play();
    emit(_getCurrentState());
  }

  void _onPauseAudio(PauseAudio event, Emitter<AudioPlayerState> emit) async {
    await audioPlayer.pause();
    emit(_getCurrentState());
  }

  void _onSeekAudio(SeekAudio event, Emitter<AudioPlayerState> emit) async {
    await audioPlayer.seek(event.position);
    emit(_getCurrentState());
  }

  AudioLoaded _getCurrentState() {
    return AudioLoaded(
      totalDuration: audioPlayer.duration ?? Duration.zero,
      currentPosition: audioPlayer.position,
      isPlaying: audioPlayer.playing,
      playingIndex: index,
    );
  }

  void _onAudioDurationChanged(
      AudioDurationChanged event, Emitter<AudioPlayerState> emit) {
    emit(_getCurrentState());
  }

  void _onAudioPositionChanged(
      AudioPositionChanged event, Emitter<AudioPlayerState> emit) {
    emit(_getCurrentState());
  }

  void _onAudioPlayingChanged(
      AudioPlayingChanged event, Emitter<AudioPlayerState> emit) {
    emit(_getCurrentState());
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
