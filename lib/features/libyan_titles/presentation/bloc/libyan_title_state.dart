part of 'libyan_title_bloc.dart';

@immutable
sealed class LibyanTitleState {}

final class LibyanTitleInitial extends LibyanTitleState {}

final class LibyanTitleFailure extends LibyanTitleState {
  final String message;

  LibyanTitleFailure({required this.message});
}

final class LibyanTitleLoading extends LibyanTitleState {}

final class LibyanTitleLoaded extends LibyanTitleState {
  final List<LibyanTitleModel> libyans;
  final bool hasReachedMax;
  final bool loadingMore;

  LibyanTitleLoaded({
    required this.libyans,
    this.hasReachedMax = false,
    this.loadingMore = false,
  });
}
