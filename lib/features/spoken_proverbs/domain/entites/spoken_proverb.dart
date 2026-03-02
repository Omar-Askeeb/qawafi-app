import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_category_model.dart';

class SpokenProverb {
  String spokenProverbsId;
  String title;
  SpokenProverbCategoryModel spokenProverbsCategory;
  String imageSrc;
  String trackSrc;
  Duration duration;
  bool isFree;
  bool isDisabled;
  dynamic addedToFavorite;

  SpokenProverb({
    required this.spokenProverbsId,
    required this.title,
    required this.spokenProverbsCategory,
    required this.imageSrc,
    required this.trackSrc,
    required this.isFree,
    required this.duration,
    required this.isDisabled,
    required this.addedToFavorite,
  });
}
