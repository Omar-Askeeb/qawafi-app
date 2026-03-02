import 'package:qawafi_app/features/ads/domain/entites/advertisement.dart';

class AdvertisementModel extends Advertisement {
  AdvertisementModel({
    required super.advertisementId,
    required super.title,
    required super.imageSrc,
    required super.url,
    required super.isDisabled,
    required super.description,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        advertisementId: json["advertisementId"],
        title: json["title"],
        imageSrc: json["imageSrc"],
        url: json["url"],
        isDisabled: json["isDisabled"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "advertisementId": advertisementId,
        "title": title,
        "imageSrc": imageSrc,
        "url": url,
        "isDisabled": isDisabled,
        "description": description,
      };
}
