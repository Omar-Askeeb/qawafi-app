import 'package:qawafi_app/features/purpose/data/models/purpose_model.dart';

import '../../../../core/utils/parse_duation.dart';
import '../../domain/entites/poem.dart';

class PoemModel extends Poem {
  PoemModel({
    required super.poemId,
    required super.title,
    required super.beginning,
    required super.description,
    required super.fileSrc,
    required super.poet,
    required super.duration,
    required super.purposeModel,
    required super.isFree,
    required super.addedToFavorite,
  });

  factory PoemModel.fromJson(Map<String, dynamic> json) => PoemModel(
        poemId: json["poemId"],
        title: json["title"],
        beginning: json["beginning"],
        description: json["description"],
        fileSrc: json["fileSrc"],
        poet: json["poet"]?['fullName'] ?? '',
        duration: parseDuration(json['duration']),
        purposeModel: (json["purpose"] == null || json["purpose"].isEmpty)
            ? null
            : PurposeModel.fromJson(json["purpose"][0]),
        isFree: json["isFree"] ?? false,
        addedToFavorite: json["addedToFavorite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "poemId": poemId,
        "title": title,
        "beginning": beginning,
        "description": description,
        "fileSrc": fileSrc,
        "poet": poet,
      };
}
