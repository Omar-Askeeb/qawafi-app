import 'package:bloc/bloc.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/entities/word.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/usecases/fetchWordsUseCase.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/entities/paginatedWords.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final FetchWordsUseCase _fetchWords;

  WordBloc({required FetchWordsUseCase fetchWords})
      : _fetchWords = fetchWords,
        super(WordInitial()) {
    on<GetWordsEvent>(_onGetWordsEvent);
  }

  void _onGetWordsEvent(GetWordsEvent event, Emitter<WordState> emit) async {
    if (event.pageNumber == 1) {
      emit(WordLoading());
    }
    final currentState = state;
    List<Word> oldWords = [];

    if (currentState is WordLoaded) {
      oldWords = currentState.words;
    } else {
      emit(WordLoading());
    }

    final result = await _fetchWords.call(event.pageNumber, event.pageSize,event.query);

    result.fold(
      (failure) => emit(WordFailure(message: failure.message , pageNumber: event.pageNumber)),
      (paginatedWords) {
        final hasReachedMax = paginatedWords.words.length < event.pageSize;
        emit(
            _mapRes(paginatedWords, oldWords, event.pageNumber, hasReachedMax));
      },
    );
  }

  WordState _mapRes(PaginatedWords paginatedWords, List<Word> oldWords,
      int pageNumber, bool hasReachedMax) {
    final newWords = paginatedWords.words;
    final allWords = oldWords + newWords;
    return WordLoaded(
      words: allWords,
      pageNumber: pageNumber,
      hasReachedMax: hasReachedMax,
    );
  }
}