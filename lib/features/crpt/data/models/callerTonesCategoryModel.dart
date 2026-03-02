import 'package:qawafi_app/features/crpt/domain/entites/callerTonesCategory.dart';

class CallerTonesCategoryModel extends CallerTonesCategory {
  CallerTonesCategoryModel(
      {required super.callerTonesCategoryId,
      required super.gender,
      required super.personName});
      
  factory CallerTonesCategoryModel.fromJson(Map<String, dynamic> json) =>
      CallerTonesCategoryModel(
        callerTonesCategoryId: json["callerTonesCategoryId"],
        gender: json["gender"],
        personName: json["personName"],
      );

  Map<String, dynamic> toJson() => {
        "callerTonesCategoryId": callerTonesCategoryId,
        "gender": gender,
        "personName": personName,
      };
}
