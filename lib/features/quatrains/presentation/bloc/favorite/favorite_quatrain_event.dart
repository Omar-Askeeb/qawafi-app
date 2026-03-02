part of 'favorite_quatrain_bloc.dart';

@immutable
sealed class FavoriteQuatrainEvent {}

final class FavoriteQuatrainInit extends FavoriteQuatrainEvent {
  final QuatrainModel quatrain;

  FavoriteQuatrainInit({required this.quatrain});
}

final class FavoriteQuatrainAdd extends FavoriteQuatrainEvent {
  final String id;

  FavoriteQuatrainAdd({required this.id});
}

final class FavoriteQuatrainRemove extends FavoriteQuatrainEvent {
  final String id;

  FavoriteQuatrainRemove({required this.id});
}
