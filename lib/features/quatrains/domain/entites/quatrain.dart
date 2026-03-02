// To parse this JSON data, do
//
//     final quatrain = quatrainFromJson(jsonString);

import '../../../quatrains_category/domain/entites/quatrains_category.dart';

class Quatrain {
  String quatrainsId;
  String title;
  QuatrainsCategory? quatrainsCategory;
  String imageSrc;
  String trackSrc;
  bool isDisabled;
  Duration duration;
  DateTime created;
  bool isFree;
  bool? addedToFavorite;

  Quatrain({
    required this.quatrainsId,
    required this.title,
    required this.quatrainsCategory,
    required this.imageSrc,
    required this.trackSrc,
    required this.isDisabled,
    required this.duration,
    required this.created,
    required this.isFree,
    required this.addedToFavorite,
  });
}
