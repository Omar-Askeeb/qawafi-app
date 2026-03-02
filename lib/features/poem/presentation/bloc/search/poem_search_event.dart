part of 'poem_search_bloc.dart';

@immutable
sealed class PoemSearchEvent {}

class PerformSearch extends PoemSearchEvent {
  final String query;
  final SearchKeys searchKeys;
  final int pageNo;
  final int pageSize;

  PerformSearch({
    required this.query,
    required this.searchKeys,
    required this.pageNo,
    this.pageSize = 10,
  });
}
