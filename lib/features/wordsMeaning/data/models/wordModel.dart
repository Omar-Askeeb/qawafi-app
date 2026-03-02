import 'package:qawafi_app/features/wordsMeaning/domain/entities/word.dart';

class WordModel extends Word {
  WordModel({
    required String id,
    required String word,
    required String meaning,
    required DateTime created,
  }) : super(
          id: id,
          word: word,
          meaning: meaning,
          created: created,
        );

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['wordsMeaningId'],
      word: json['word'],
      meaning: json['meaning'],
      created: DateTime.parse(json['created']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wordsMeaningId': id,
      'word': word,
      'meaning': meaning,
      'created': created.toIso8601String(),
    };
  }
}
