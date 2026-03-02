import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/getProverbStories.dart';

part 'list_story_proverb_event.dart';
part 'list_story_proverb_state.dart';

class ListStoryProverbBloc
    extends Bloc<ListStoryProverbEvent, ListStoryProverbState> {
  final GetProverbStories _getStoryProverb;
//  final UpdateFavoriteStatus _updateStoryProverbFavoriteUseCase;
//  final GetProverbStoriesById _getProverbStoriesById;
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  ListStoryProverbBloc({
    required GetProverbStories getStoryProverb,
    // required UpdateFavoriteStatus updateStoryProverbFavorite,
    //required GetProverbStoriesById getProverbStoriesById,
  })  : _getStoryProverb = getStoryProverb,
        //  _updateStoryProverbFavoriteUseCase = updateStoryProverbFavorite,
        //  _getProverbStoriesById = getProverbStoriesById,
        super(ListStoryProverbInitial()) {
    on<GetStoryProverbsEvent>(_onGetStoryProverbs);
    // on<UpdateStoryProverbFavoriteEvent>(_onUpdateStoryProverbFavorite);
    // on<PlayPauseEvent>(_togglePlayPause); // تأكد من استخدام الاسم الصحيح هنا
    // on<UpdateProgressEvent>(_onUpdateProgress);
    // on<SelectStoryProverbEvent>(_onSelectStoryProverb);
    // on<PauseEvent>(_onPauseWhenClose);
    // on<ResetPositionEvent>(_onResetPosition);
  }

  Future<void> _onGetStoryProverbs(
      GetStoryProverbsEvent event, Emitter<ListStoryProverbState> emit) async {
    // if (state is ListStoryProverbLoaded) {
    //   emit(
    //     ListStoryProverbLoaded(
    //       currentStoryProverb:
    //           (state as ListStoryProverbLoaded).currentStoryProverb,
    //       storyProverbs: (state as ListStoryProverbLoaded).storyProverbs,
    //     ),
    //   );
    //   return;
    // }
    if (state is! ListStoryProverbLoaded) {
      emit(ListStoryProverbLoading());
    }
    final res = await _getStoryProverb(GetProverbStoriesParams(
        pageNumber: event.pageNumber, pageSize: event.pageSize));
    res.fold(
      (failure) => emit(ListStoryProverbFailure(message: failure.message)),
      (stories) {
        final defaultStory = stories.isNotEmpty
            ? stories.firstWhere((element) => element.isFree)
            : null;
        if (defaultStory != null) {
          emit(ListStoryProverbLoaded(
            currentStoryProverb: defaultStory,
            storyProverbs: stories,
          ));
        } else {
          emit(ListStoryProverbFailure(message: 'لا توجد قصص متوفرة الأن'));
        }
      },
    );
  }

  // Future<void> _onUpdateStoryProverbFavorite(
  //     UpdateStoryProverbFavoriteEvent event,
  //     Emitter<ListStoryProverbState> emit) async {
  //   try {
  //     final currentState = state;
  //     if (currentState is StoryProverbLoaded) {
  //       final updatedStoryProverbs = currentState.storyProverbs.map((story) {
  //         if (story.proverbStoryId == event.storyProverbId) {
  //           return ProverbStory(
  //             proverbStoryId: story.proverbStoryId,
  //             title: story.title,
  //             description: story.description,
  //             imageSrc: story.imageSrc,
  //             trackSrc: story.trackSrc,
  //             addedToFavorite: event.isFavorite,
  //             duration: story.duration,
  //           );
  //         }
  //         return story;
  //       }).toList();

  //       final updatedStory = updatedStoryProverbs.firstWhere(
  //           (story) => story.proverbStoryId == event.storyProverbId);

  //       emit(StoryProverbFavoriteUpdated(updatedStoryProverb: updatedStory));

  //       emit(StoryProverbLoaded(
  //         currentStoryProverb: currentState.currentStoryProverb,
  //         storyProverbs: updatedStoryProverbs,
  //         isPlaying: currentState.isPlaying,
  //         currentPosition: currentState.currentPosition,
  //       ));
  //     }
  //   } catch (e) {
  //     emit(StoryProverbFailure(message: e.toString()));
  //   }
  // }

  // Future<void> _togglePlayPause(
  //     PlayPauseEvent event, Emitter<StoryProverbState> emit) async {
  //   try {
  //     final currentState = state;
  //     if (currentState is StoryProverbLoaded) {
  //       if (currentState.isPlaying) {
  //         await _audioPlayer.pause();
  //         emit(StoryProverbLoaded(
  //           currentStoryProverb: currentState.currentStoryProverb,
  //           storyProverbs: currentState.storyProverbs,
  //           isPlaying: false,
  //           currentPosition: _audioPlayer.position,
  //         ));
  //       } else {
  //         await _audioPlayer.setUrl(currentState.currentStoryProverb.trackSrc);
  //         emit(StoryProverbLoaded(
  //           currentStoryProverb: currentState.currentStoryProverb,
  //           storyProverbs: currentState.storyProverbs,
  //           isPlaying: true,
  //           currentPosition: _audioPlayer.position,
  //         ));
  //         await _audioPlayer.play();
  //       }
  //     }
  //   } catch (e) {
  //     emit(StoryProverbFailure(message: e.toString()));
  //   }
  // }

  // Future<void> _onUpdateProgress(
  //     UpdateProgressEvent event, Emitter<StoryProverbState> emit) async {
  //   try {
  //     final currentState = state;
  //     if (currentState is StoryProverbLoaded) {
  //       await _audioPlayer.seek(event.position);
  //       emit(StoryProverbLoaded(
  //         currentStoryProverb: currentState.currentStoryProverb,
  //         storyProverbs: currentState.storyProverbs,
  //         isPlaying: currentState.isPlaying,
  //         currentPosition: event.position,
  //       ));
  //     }
  //   } catch (e) {
  //     emit(StoryProverbFailure(message: e.toString()));
  //   }
  // }

  // Future<void> _onSelectStoryProverb(
  //     SelectStoryProverbEvent event, Emitter<StoryProverbState> emit) async {
  //   try {
  //     final List<ProverbStory>? list;
  //     list = state is StoryProverbLoaded ? (state as StoryProverbLoaded).storyProverbs : null;
  //     // if(state is StoryProverbLoaded){
  //     //     list = state.
  //     // }
  //     emit(StoryProverbLoading());
  //     final result = await _getProverbStoriesById(
  //         GetProverbStoriesByIdParams(id: event.storyProverbId.toString()));

  //     await result.fold((failure) async {
  //       emit(StoryProverbFailure(message: failure.message));
  //     }, (selectedStory) async {
  //       final currentState = state;
  //       List<ProverbStory> currentStories = [];
  //       if (currentState is StoryProverbLoaded) {
  //         currentStories = currentState.storyProverbs;

  //       }

  //       await _audioPlayer.setUrl(selectedStory.trackSrc);
  //       emit(StoryProverbLoaded(
  //         currentStoryProverb: selectedStory,
  //         storyProverbs: list ?? [], // الاحتفاظ بالقائمة الحالية
  //         isPlaying: true,
  //         currentPosition: Duration.zero,
  //       ));
  //       await _audioPlayer.play();
  //     });
  //   } catch (e) {
  //     emit(StoryProverbFailure(message: e.toString()));
  //   }
  // }

  // Future<void> _onPauseWhenClose(
  //     PauseEvent event, Emitter<StoryProverbState> emit) async {
  //   await _audioPlayer.pause();
  // }

  // Future<void> _onResetPosition(
  //     ResetPositionEvent event, Emitter<StoryProverbState> emit) async {
  //   if (state is StoryProverbLoaded) {
  //     emit(StoryProverbLoaded(
  //       currentStoryProverb: (state as StoryProverbLoaded).currentStoryProverb,
  //       storyProverbs: (state as StoryProverbLoaded).storyProverbs,
  //       isPlaying: false,
  //       currentPosition: Duration.zero,
  //     ));
  //   }
  // }

  // @override
  // Future<void> close() {
  //   _audioPlayer.pause();
  //   //  _audioPlayer.position;
  //   UpdateProgressEvent(Duration.zero);
  //   return super.close();
  // }
}
