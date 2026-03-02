import 'package:qawafi_app/features/melody/domain/entities/melody.dart';

class MelodyModel extends Melody {
  MelodyModel({
    required super.id,
    required super.name,
  });

  factory MelodyModel.fromJson(Map<String, dynamic> json) => MelodyModel(
        id: json["melodiesId"],
        name: json["melodiesName"],
      );

  Map<String, dynamic> toJson() => {
        "melodiesId": id,
        "melodiesName": name,
      };
}
