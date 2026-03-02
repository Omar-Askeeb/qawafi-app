part of 'most_streamed_and_newest_bloc.dart';

@immutable
sealed class MostStreamedAndNewestEvent {}

class FetchMostStreamedAndNewest extends MostStreamedAndNewestEvent {}
