part of 'spoken_proverb_bloc.dart';

@immutable
sealed class SpokenProverbEvent {}

final class SpokenProverbFetchEvent extends SpokenProverbEvent {
  final String categoryId;

  SpokenProverbFetchEvent({required this.categoryId});
}
