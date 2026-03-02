import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/getProverbStoryById.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/updateFavoriteStatus.dart';

import '../../../../../core/localStorage/loacal_storage.dart';

part 'playerStoryProverb_event.dart';
part 'PlayerStoryProverb_state.dart';

class PlayerStoryProverbBloc
    extends Bloc<PlayerStoryProverbEvent, PlayerStoryProverbState> {
  // final GetProverbStories _getStoryProverb;
  final UpdateFavoriteStatus _updateStoryProverbFavoriteUseCase;
  final LocalStorage _localStorage;

  final GetProverbStoriesById _getProverbStoriesById;
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  PlayerStoryProverbBloc({
    // required GetProverbStories getStoryProverb,
    required UpdateFavoriteStatus updateStoryProverbFavorite,
    required GetProverbStoriesById getProverbStoriesById,
    required LocalStorage localStorage,
  })  : // _getStoryProverb = getStoryProverb,
        _updateStoryProverbFavoriteUseCase = updateStoryProverbFavorite,
        _getProverbStoriesById = getProverbStoriesById,
        _localStorage = localStorage,
        super(PlayerStoryProverbInitial()) {
    // on<GetStoryProverbsEvent>(_onGetStoryProverbs);
    on<UpdateStoryProverbFavoriteEvent>(_onUpdateStoryProverbFavorite);
    on<PlayPauseEvent>(_togglePlayPause); // تأكد من استخدام الاسم الصحيح هنا
    on<UpdateProgressEvent>(_onUpdateProgress);
    on<SelectStoryProverbEvent>(_onSelectStoryProverb);
    on<PauseEvent>(_onPauseWhenClose);
    on<ResetPositionEvent>(_onResetPosition);
  }

  // Future<void> _onGetStoryProverbs(
  //     GetStoryProverbsEvent event, Emitter<StoryProverbState> emit) async {
  //   emit(StoryProverbLoading());
  //   final res = await _getStoryProverb(GetProverbStoriesParams(
  //       pageNumber: event.pageNumber, pageSize: event.pageSize));
  //   res.fold(
  //     (failure) => emit(StoryProverbFailure(message: failure.message)),
  //     (stories) {
  //       final defaultStory = stories.isNotEmpty ? stories[0] : null;
  //       if (defaultStory != null) {
  //         emit(StoryProverbLoaded(
  //           currentStoryProverb: defaultStory,
  //           storyProverbs: stories,
  //         ));
  //       } else {
  //         emit(StoryProverbFailure(message: 'لا توجد قصص متوفرة الأن'));
  //       }
  //     },
  //   );
  // }

  Future<void> _onUpdateStoryProverbFavorite(
      UpdateStoryProverbFavoriteEvent event,
      Emitter<PlayerStoryProverbState> emit) async {
    // try {
    //   final currentState = state;
    //   if (currentState is StoryProverbLoaded) {
    //     final updatedStoryProverbs = currentState.storyProverbs.map((story) {
    //       if (story.proverbStoryId == event.storyProverbId) {
    //         return ProverbStory(
    //           proverbStoryId: story.proverbStoryId,
    //           title: story.title,
    //           description: story.description,
    //           imageSrc: story.imageSrc,
    //           trackSrc: story.trackSrc,
    //           addedToFavorite: event.isFavorite,
    //           duration: story.duration,
    //         );
    //       }
    //       return story;
    //     }).toList();

    //     final updatedStory = updatedStoryProverbs.firstWhere(
    //         (story) => story.proverbStoryId == event.storyProverbId);

    //     emit(StoryProverbFavoriteUpdated(updatedStoryProverb: updatedStory));

    //     emit(StoryProverbLoaded(
    //       currentStoryProverb: currentState.currentStoryProverb,
    //      // storyProverbs: updatedStoryProverbs,
    //       isPlaying: currentState.isPlaying,
    //       currentPosition: currentState.currentPosition,
    //     ));
    //   }
    // } catch (e) {
    //   emit(StoryProverbFailure(message: e.toString()));
    // }
  }

  Future<void> _togglePlayPause(
      PlayPauseEvent event, Emitter<PlayerStoryProverbState> emit) async {
    try {
      final currentState = state;
      if (currentState is PlayerStoryProverbLoaded) {
        if (currentState.isPlaying) {
          await _audioPlayer.pause();
          emit(PlayerStoryProverbLoaded(
            currentStoryProverb: currentState.currentStoryProverb,
            // storyProverbs: currentState.storyProverbs,
            isPlaying: false,
            currentPosition: _audioPlayer.position,
          ));
        } else {
          // await _audioPlayer.setUrl(
          //   currentState.currentStoryProverb.trackSrc,
          //   headers: {
          //     "Authorization": await _localStorage.accessToken,
          //   },
          // );
          final audioSource = ProgressiveAudioSource(
            Uri.parse(currentState.currentStoryProverb.trackSrc),
            headers: {
              "Authorization": await _localStorage.accessToken,
            },
          );

          // Set the audio source to the player
          await _audioPlayer.setAudioSource(audioSource);
          emit(PlayerStoryProverbLoaded(
            currentStoryProverb: currentState.currentStoryProverb,
            //  storyProverbs: currentState.storyProverbs,
            isPlaying: true,
            currentPosition: _audioPlayer.position,
          ));
          await _audioPlayer.play();
        }
      }
    } catch (e) {
      emit(PlayerStoryProverbFailure(message: e.toString()));
    }
  }

  Future<void> _onUpdateProgress(
      UpdateProgressEvent event, Emitter<PlayerStoryProverbState> emit) async {
    try {
      final currentState = state;
      if (currentState is PlayerStoryProverbLoaded) {
        await _audioPlayer.seek(event.position);
        emit(PlayerStoryProverbLoaded(
          currentStoryProverb: currentState.currentStoryProverb,
          //storyProverbs: currentState.storyProverbs,
          isPlaying: currentState.isPlaying,
          currentPosition: event.position,
        ));
      }
    } catch (e) {
      emit(PlayerStoryProverbFailure(message: e.toString()));
    }
  }

  Future<void> _onSelectStoryProverb(SelectStoryProverbEvent event,
      Emitter<PlayerStoryProverbState> emit) async {
    try {
      // final List<ProverbStory>? list;
      //list = state is StoryProverbLoaded ? (state as StoryProverbLoaded).storyProverbs : null;
      // if(state is StoryProverbLoaded){
      //     list = state.
      // }
      emit(PlayerStoryProverbLoading());
      final result = await _getProverbStoriesById(
          GetProverbStoriesByIdParams(id: event.storyProverbId.toString()));

      await result.fold((failure) async {
        emit(PlayerStoryProverbFailure(message: failure.message));
      }, (selectedStory) async {
        final currentState = state;
        // List<ProverbStory> currentStories = [];
        // if (currentState is StoryProverbLoaded) {
        //   currentStories = currentState.storyProverbs;

        // }

        await _audioPlayer.setUrl(selectedStory.trackSrc);
        emit(PlayerStoryProverbLoaded(
          currentStoryProverb: selectedStory,
          //  storyProverbs: list ?? [], // الاحتفاظ بالقائمة الحالية
          isPlaying: event.isPlay,
          currentPosition: Duration.zero,
        ));
        if (event.isPlay) {
          await _audioPlayer.play();
        }
      });
    } catch (e) {
      emit(PlayerStoryProverbFailure(message: e.toString()));
    }
  }

  Future<void> _onPauseWhenClose(
      PauseEvent event, Emitter<PlayerStoryProverbState> emit) async {
    await _audioPlayer.pause();
  }

  Future<void> _onResetPosition(
      ResetPositionEvent event, Emitter<PlayerStoryProverbState> emit) async {
    if (state is PlayerStoryProverbLoaded) {
      emit(PlayerStoryProverbLoaded(
        currentStoryProverb:
            (state as PlayerStoryProverbLoaded).currentStoryProverb,
        //storyProverbs: (state as StoryProverbLoaded).storyProverbs,
        isPlaying: false,
        currentPosition: Duration.zero,
      ));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.pause();
    //  _audioPlayer.position;
    UpdateProgressEvent(Duration.zero);
    return super.close();
  }
}
