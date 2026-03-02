part of 'quatrains_category_bloc.dart';

@immutable
sealed class QuatrainsCategoryState {}

final class QuatrainsCategoryInitial extends QuatrainsCategoryState {}

final class QuatrainsCategoryLoading extends QuatrainsCategoryState {}

final class QuatrainsCategoryFailure extends QuatrainsCategoryState {
  final String message;

  QuatrainsCategoryFailure({required this.message});
}

final class QuatrainsCategorySuccess extends QuatrainsCategoryState {
  final List<QuatrainsCategoryModel> list;

  QuatrainsCategorySuccess({required this.list});
}
