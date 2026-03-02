import '../../domain/entites/quatrains_category.dart';

class QuatrainsCategoryModel extends QuatrainsCategory {
  QuatrainsCategoryModel({
    required super.quatrainsCategoryId,
    required super.title,
    required super.imageSrc,
    required super.created,
    required super.lastModified,
  });
  factory QuatrainsCategoryModel.fromJson(Map<String, dynamic> json) =>
      QuatrainsCategoryModel(
        quatrainsCategoryId: json["quatrainsCategoryId"],
        title: json["title"],
        imageSrc: json["imageSrc"],
        created: DateTime.parse(json["created"]),
        lastModified: json["lastModified"] != null
            ? DateTime.parse(json["lastModified"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "quatrainsCategoryId": quatrainsCategoryId,
        "title": title,
        "created": created.toIso8601String(),
        "lastModified": lastModified,
      };
}
