import 'package:qawafi_app/features/poem/data/models/poem_model.dart';

import '../../domain/entites/poem_data.dart';

class PoemDataModel extends PoemData {
  PoemDataModel({
    required List<PoemModel> super.poems,
    required super.pageNumber,
    required super.pageSize,
    required super.totalAvailable,
  });

  factory PoemDataModel.fromJson(Map<String, dynamic> json) => PoemDataModel(
        poems: List<PoemModel>.from(
            json["list"].map((x) => PoemModel.fromJson(x))),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalAvailable: json["totalAvailable"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "list": List<PoemModel>.from(
            (poems as List<PoemModel>).map((x) => x.toJson())),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalAvailable": totalAvailable,
      };
}
