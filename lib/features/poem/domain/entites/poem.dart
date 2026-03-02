import '../../../purpose/data/models/purpose_model.dart';

class Poem {
  String poemId;
  String title;
  String beginning;
  String description;
  String fileSrc;
  String poet;
  Duration duration;
  PurposeModel? purposeModel;
  bool isFree;
  bool addedToFavorite;

  Poem({
    required this.poemId,
    required this.title,
    required this.beginning,
    required this.description,
    required this.fileSrc,
    required this.poet,
    required this.duration,
    required this.purposeModel,
    required this.isFree,
    required this.addedToFavorite,
  });
}
