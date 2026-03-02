part of 'poet_bloc.dart';

@immutable
sealed class PoetState {}

final class PoetInitial extends PoetState {}

final class PoetLoading extends PoetState {}

final class PoetFailuer extends PoetState {
  final String message;

  PoetFailuer({required this.message});
}

final class PoetProfile extends PoetState {
  final PoetModel poet;
  final PoemDataModel poems;

  PoetProfile({
    required this.poet,
    required this.poems,
  });
}

final class PoetSuccess extends PoetState {
  PoetSuccess({
    required this.poets,
    this.loadingMore = false,
  });

  final List<PoetModel> poets;
  final bool loadingMore;
}
