import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_category_model.dart';
import 'package:qawafi_app/features/spoken_proverbs/domain/entites/spoken_proverb.dart';

import '../../../../core/utils/parse_duation.dart';

class SpokenProverbModel extends SpokenProverb {
  SpokenProverbModel({
    required super.spokenProverbsId,
    required super.title,
    required super.spokenProverbsCategory,
    required super.imageSrc,
    required super.trackSrc,
    required super.duration,
    required super.isDisabled,
    required super.isFree,
    required super.addedToFavorite,
  });

  factory SpokenProverbModel.fromJson(Map<String, dynamic> json) =>
      SpokenProverbModel(
        spokenProverbsId: json["spokenProverbsId"],
        title: json["title"],
        spokenProverbsCategory:
            SpokenProverbCategoryModel.fromJson(json["spokenProverbsCategory"]),
        imageSrc: json["imageSrc"],
        trackSrc: json["trackSrc"],
        isFree: json["isFree"],
        duration: parseDuration(json["duration"]),
        isDisabled: json["isDisabled"],
        addedToFavorite: json["addedToFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "spokenProverbsId": spokenProverbsId,
        "title": title,
        "spokenProverbsCategory": spokenProverbsCategory.toJson(),
        "imageSrc": imageSrc,
        "trackSrc": trackSrc,
        "duration": duration,
        "isDisabled": isDisabled,
        "addedToFavorite": addedToFavorite,
      };
}
