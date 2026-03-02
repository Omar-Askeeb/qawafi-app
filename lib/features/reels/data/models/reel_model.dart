import '../../domain/entites/reel.dart';

class ReelModel extends Reel {
  ReelModel({
    required String reelsId,
    required String title,
    required String description,
    required String videoSrc,
    required bool isDisabled,
  }) : super(
          reelsId: reelsId,
          title: title,
          description: description,
          videoSrc: videoSrc,
          isDisabled: isDisabled,
        );

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      reelsId: json['reelsId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoSrc: json['videoSrc'] as String,
      isDisabled: json['isDisabled'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reelsId': reelsId,
      'title': title,
      'description': description,
      'videoSrc': videoSrc,
      'isDisabled': isDisabled,
    };
  }
}
