part of 'quatrains_category_bloc.dart';

@immutable
sealed class QuatrainsCategoryEvent {}

final class QuatrainsCategoryFetch extends QuatrainsCategoryEvent {
  final int pageNo;
  final int pageSize;
  final String? query;

  QuatrainsCategoryFetch({
    required this.pageNo,
    required this.pageSize,
    required this.query,
  });
}

final class QuatrainsCategoryChoose extends QuatrainsCategoryEvent {
  final String categoryId;

  QuatrainsCategoryChoose({required this.categoryId});
}
