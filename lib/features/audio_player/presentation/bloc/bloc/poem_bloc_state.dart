part of 'poem_bloc_bloc.dart';

@immutable
sealed class PoemBlocState {}

final class PoemBlocInitial extends PoemBlocState {}

final class PoemBlocLoading extends PoemBlocState {}

final class PoemBlocFailure extends PoemBlocState {
  final String message;

  PoemBlocFailure({required this.message});
}

final class PoemBlocLoaded extends PoemBlocState {
  final PoemModel poem;

  PoemBlocLoaded({required this.poem});
}
