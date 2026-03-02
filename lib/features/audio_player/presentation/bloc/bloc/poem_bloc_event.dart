part of 'poem_bloc_bloc.dart';

@immutable
sealed class PoemBlocEvent {}

final class PoemBlocFetchEvent extends PoemBlocEvent {
  final String poemId;

  PoemBlocFetchEvent({required this.poemId});
}
