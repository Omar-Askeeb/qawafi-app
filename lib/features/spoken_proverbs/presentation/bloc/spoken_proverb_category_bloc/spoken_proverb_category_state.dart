part of 'spoken_proverb_category_bloc.dart';

@immutable
sealed class SpokenProverbCategoryState {}

final class SpokenProverbCategoryInitial extends SpokenProverbCategoryState {}

final class SpokenProverbCategoryLoading extends SpokenProverbCategoryState {}

final class SpokenProverbCategoryFailure extends SpokenProverbCategoryState {
  final String message;

  SpokenProverbCategoryFailure({required this.message});
}

final class SpokenProverbCategoryLoaded extends SpokenProverbCategoryState {
  final List<SpokenProverbCategoryModel> categories;

  SpokenProverbCategoryLoaded({required this.categories});
}
