part of 'list_story_proverb_bloc.dart';

abstract class ListStoryProverbEvent {}

class GetStoryProverbsEvent extends ListStoryProverbEvent {
  final int pageNumber;
  final int pageSize;
  final bool isFirstFetch;

  GetStoryProverbsEvent({
    required this.pageNumber,
    required this.pageSize,
    this.isFirstFetch = false,
  });
}
