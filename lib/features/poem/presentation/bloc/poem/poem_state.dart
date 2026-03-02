part of 'poem_bloc.dart';

@immutable
sealed class PoemState {}

final class PoemInitial extends PoemState {}

final class PoemLoading extends PoemState {}

final class PoemFailure extends PoemState {
  final String message;

  PoemFailure({required this.message});
}

final class PoemSuccess extends PoemState {
  final PoemDataModel poemDataModel;
  final String purpose;
  final int category;
  final bool hasReachedMax;

  PoemSuccess({
    required this.purpose,
    required this.category,
    required this.poemDataModel,
    this.hasReachedMax = false,
  });

  PoemSuccess copyWith({
    final PoemDataModel? poemDataModel,
    final String? purpose,
    final int? category,
    bool? hasReachedMax,
  }) {
    return PoemSuccess(
      poemDataModel: poemDataModel ?? this.poemDataModel,
      category: category ?? this.category,
      purpose: purpose ?? this.purpose,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
