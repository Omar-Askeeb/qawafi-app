part of 'word_bloc.dart';

abstract class WordEvent {}

class GetWordsEvent extends WordEvent {
  final int pageNumber;
  final int pageSize;
  final bool isFirstFetch;
  final String query;

  GetWordsEvent({
    required this.pageNumber,
    required this.pageSize,
    this.isFirstFetch = false,
    required this.query
  });

}
