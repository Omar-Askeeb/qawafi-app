part of 'popularProverbs_bloc.dart';

@immutable
abstract class PopularProverbsState {
  const PopularProverbsState();
}

class PopularProverbsInitial extends PopularProverbsState {}

class PopularProverbsLoading extends PopularProverbsState {}

class PopularProverbsLoaded extends PopularProverbsState {
  final List<PopularProverbs> popularProverbs;

  const PopularProverbsLoaded({required this.popularProverbs});
}

class PopularProverbsFailure extends PopularProverbsState {
  final String message;

  const PopularProverbsFailure({required this.message});
}