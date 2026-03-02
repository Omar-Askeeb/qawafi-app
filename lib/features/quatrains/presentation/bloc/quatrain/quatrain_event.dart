part of 'quatrain_bloc.dart';

@immutable
sealed class QuatrainEvent {}

final class QuatrainFetchData extends QuatrainEvent {
  final int pageNo;
  final int pageSize;
  final String categoryId;
  final String? query;

  QuatrainFetchData({
    required this.pageNo,
    required this.pageSize,
    required this.categoryId,
    this.query,
  });
}

final class QuatrainFetchById extends QuatrainEvent {
  final String id;

  QuatrainFetchById({required this.id});
}
