import 'package:qawafi_app/features/wordsMeaning/domain/entities/paginatedWords.dart';

import 'wordModel.dart';

class PaginatedWordsModel extends PaginatedWords {
  PaginatedWordsModel({
    required List<WordModel> words,
    required int pageNumber,
    required int pageSize,
    int? totalAvailable,
  }) : super(
          words: words,
          pageNumber: pageNumber,
          pageSize: pageSize,
          totalAvailable: totalAvailable,
        );

  factory PaginatedWordsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return PaginatedWordsModel(
      words: (data['list'] as List)
          .map((wordJson) => WordModel.fromJson(wordJson))
          .toList(),
      pageNumber: data['pageNumber'],
      pageSize: data['pageSize'],
      totalAvailable: data['totalAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': words.map((word) => (word as WordModel).toJson()).toList(),
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalAvailable': totalAvailable,
    };
  }
}
