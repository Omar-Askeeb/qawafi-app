import 'package:qawafi_app/features/libyan_titles/domain/entites/poetic_verse.dart';

class PoeticVerseModel extends PoeticVerse {
  PoeticVerseModel({
    required super.poeticVersesId,
    required super.verse,
    required super.description,
    required super.created,
  });

  factory PoeticVerseModel.fromJson(Map<String, dynamic> json) =>
      PoeticVerseModel(
        poeticVersesId: json["poeticVersesId"],
        verse: json["verse"],
        description: json["description"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "poeticVersesId": poeticVersesId,
        "verse": verse,
        "description": description,
        "created": created.toIso8601String(),
      };
}
