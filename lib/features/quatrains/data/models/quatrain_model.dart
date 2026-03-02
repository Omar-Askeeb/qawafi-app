import 'package:qawafi_app/core/utils/parse_duation.dart';
import 'package:qawafi_app/features/quatrains_category/data/models/quatrains_category_model.dart';

import '../../domain/entites/quatrain.dart';

class QuatrainModel extends Quatrain {
  QuatrainModel({
    required super.quatrainsId,
    required super.title,
    required super.quatrainsCategory,
    required super.imageSrc,
    required super.trackSrc,
    required super.isDisabled,
    required super.duration,
    required super.created,
    required super.isFree,
    required super.addedToFavorite,
  });

  factory QuatrainModel.fromJson(Map<String, dynamic> json) => QuatrainModel(
        quatrainsId: json["quatrainsId"],
        title: json["title"],
        quatrainsCategory: json["quatrainsCategory"] != null
            ? QuatrainsCategoryModel.fromJson(json["quatrainsCategory"])
            : null,
        imageSrc: json["imageSrc"],
        trackSrc: json["trackSrc"],
        isDisabled: json["isDisabled"],
        duration: parseDuration(json["duration"]),
        created: DateTime.parse(json["created"]),
        isFree: json['isFree'],
        addedToFavorite: json["addedToFavorite"],
      );
}
