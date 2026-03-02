part of 'reels_bloc.dart';

@immutable
sealed class ReelsState {}

final class ReelsInitial extends ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsFailure extends ReelsState {
  final String message;

  ReelsFailure({required this.message});
}

class ReelsSuccess extends ReelsState {
  final List<ReelModel> reels;

  ReelsSuccess({required this.reels});
}
