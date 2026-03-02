part of 'poem_bloc.dart';

@immutable
sealed class PoemEvent {}

final class PoemGetByPurposeAndCategory extends PoemEvent {
  final Purpose purpose;
  final String category;
  final int pageNo;
  final int pageSize;

  PoemGetByPurposeAndCategory({
    required this.purpose,
    required this.category,
    required this.pageNo,
    this.pageSize = 10,
  });
}

final class PoemGetByCategoryAndMelody extends PoemEvent {
  final String? melody;
  final String category;

  PoemGetByCategoryAndMelody({this.melody, required this.category});
}
