part of 'favorite_quatrain_bloc.dart';

@immutable
sealed class FavoriteQuatrainState {}

final class FavoriteQuatrainInitial extends FavoriteQuatrainState {}

final class FavoriteQuatrainLoading extends FavoriteQuatrainState {}

final class FavoriteQuatrainFailure extends FavoriteQuatrainState {
  final String message;

  FavoriteQuatrainFailure({required this.message});
}

final class FavoriteQuatrainSuccess extends FavoriteQuatrainState {
  final QuatrainModel quatrain;

  FavoriteQuatrainSuccess({required this.quatrain});
}
