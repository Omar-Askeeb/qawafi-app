import 'package:qawafi_app/features/libyan_titles/data/models/poetic_verse_model.dart';
import 'package:qawafi_app/features/libyan_titles/domain/entites/libyan_title.dart';

class LibyanTitleModel extends LibyanTitle {
  final bool isExpanded = false;
  LibyanTitleModel({
    required super.libyanTitlesId,
    required super.title,
    required super.description,
    required super.poeticVerses,
    required super.isDisabled,
    required super.created,
    required super.isFree,
  });

  factory LibyanTitleModel.fromJson(Map<String, dynamic> json) =>
      LibyanTitleModel(
        libyanTitlesId: json["libyanTitlesId"],
        title: json["title"],
        description: json["description"],
        poeticVerses: List<PoeticVerseModel>.from(
            json["poeticVerses"].map((x) => PoeticVerseModel.fromJson(x))),
        isFree: json["isFree"],
        isDisabled: json["isDisabled"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "libyanTitlesId": libyanTitlesId,
        "title": title,
        "description": description,
        "poeticVerses": List<dynamic>.from(
            poeticVerses.map((x) => (x as PoeticVerseModel).toJson())),
        "isDisabled": isDisabled,
        "created": created.toIso8601String(),
      };
}
