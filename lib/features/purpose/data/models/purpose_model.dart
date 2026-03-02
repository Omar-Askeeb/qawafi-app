import '../../domain/entites/purpose.dart';
// List<Purpose> purposeFromJson(String str) => List<Purpose>.from(json.decode(str).map((x) => Purpose.fromJson(x)));
// Purpose purposeFromJson2(String str) => Purpose.fromJson(json.decode(str));

class PurposeModel extends Purpose {
  PurposeModel({
    required super.purposeId,
    required super.purposeName,
    required super.imageSrc,
  });
  factory PurposeModel.fromJson(Map<String, dynamic> json) => PurposeModel(
        purposeId: json["purposeId"],
        purposeName: json["purposeName"],
        imageSrc: json["imageSrc"],
      );

  Map<String, dynamic> toJson() => {
        "purposeId": purposeId,
        "purposeName": purposeName,
        "imageSrc": imageSrc,
      };
}
