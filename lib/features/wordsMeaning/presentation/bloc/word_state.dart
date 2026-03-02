part of 'word_bloc.dart';

abstract class WordState {}

class WordInitial extends WordState {}

class WordLoading extends WordState {}

class WordLoaded extends WordState {
  final List<Word> words;
  final int pageNumber;
  final bool hasReachedMax;
  WordLoaded({
    required this.words,
    required this.pageNumber,
    required this.hasReachedMax,
  
  });

  get query => null;

  WordLoaded copyWith({
    List<Word>? words,
    int? pageNumber,
    bool? hasReachedMax,
  
  }) {
    return WordLoaded(
      words: words ?? this.words,
      pageNumber: pageNumber ?? this.pageNumber,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class WordFailure extends WordState {
  final String message; // error message
  final int pageNumber;
  WordFailure({required this.message , required this.pageNumber});
}
