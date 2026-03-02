part of 'spoken_proverb_bloc.dart';

@immutable
sealed class SpokenProverbState {}

final class SpokenProverbInitial extends SpokenProverbState {}

final class SpokenProverbLoading extends SpokenProverbState {}

final class SpokenProverbFailure extends SpokenProverbState {
  final String message;

  SpokenProverbFailure({required this.message});
}

final class SpokenProverbLoaded extends SpokenProverbState {
  final List<SpokenProverbModel> spokenProverbs;

  SpokenProverbLoaded({required this.spokenProverbs});
}
