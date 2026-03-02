import 'package:qawafi_app/features/wordsMeaning/domain/entities/word.dart';

class PaginatedWords {
  final List<Word> words;
  final int pageNumber;
  final int pageSize;
  final int? totalAvailable;

  PaginatedWords({
    required this.words,
    required this.pageNumber,
    required this.pageSize,
    this.totalAvailable,
  });
}
