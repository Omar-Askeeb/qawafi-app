import 'package:qawafi_app/features/spoken_proverbs/domain/entites/spoken_proverb_category.dart';

class SpokenProverbCategoryModel extends SpokenProverbCategory {
  SpokenProverbCategoryModel(
      {required super.spokenProverbsCategoryId, required super.title});

  factory SpokenProverbCategoryModel.fromJson(Map<String, dynamic> json) =>
      SpokenProverbCategoryModel(
        spokenProverbsCategoryId: json["spokenProverbsCategoryId"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "spokenProverbsCategoryId": spokenProverbsCategoryId,
        "title": title,
      };
}
