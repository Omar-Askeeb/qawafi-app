part of 'quatrain_bloc.dart';

@immutable
sealed class QuatrainState {}

final class QuatrainInitial extends QuatrainState {}

final class QuatrainLoading extends QuatrainState {}

final class QuatrainFailure extends QuatrainState {
  final String message;

  QuatrainFailure({required this.message});
}

final class QuatrainSuccess extends QuatrainState {
  final List<QuatrainModel> quatrains;

  QuatrainSuccess({required this.quatrains});
}

final class QuatrainOneSuccess extends QuatrainState {
  final QuatrainModel quatrain;

  QuatrainOneSuccess({required this.quatrain});
}
