import 'package:qawafi_app/core/utils/parse_duation.dart';
import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';

class ProverbStoryModel extends ProverbStory {
  ProverbStoryModel({
    required super.proverbStoryId,
    required super.title,
    required super.description,
    required super.imageSrc,
    required super.trackSrc,
    required super.isFree,
    required super.duration,
    super.addedToFavorite,
  });
  factory ProverbStoryModel.fromJson(Map<String, dynamic> json) {
    return ProverbStoryModel(
      proverbStoryId: json['proverbStoryId'],
      title: json['title'],
      description: json['description'],
      imageSrc: json['imageSrc'],
      trackSrc: json['trackSrc'],
      isFree: json['isFree'],
      duration: parseDuration(json['duration']),
      addedToFavorite: json['addedToFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'proverbStoryId': proverbStoryId,
      'title': title,
      'description': description,
      'imageSrc': imageSrc,
      'trackSrc': trackSrc,
      'duration': duration,
      'addedToFavorite': addedToFavorite,
    };
  }
}
