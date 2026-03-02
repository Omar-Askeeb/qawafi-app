import 'package:qawafi_app/features/crpt/domain/entites/callerTones.dart';

class CallerTonesModel extends CallerTone {
  CallerTonesModel({
    required super.callerTonesId,
    required super.toneCodeL,
    required super.toneCodeM,
    required super.toneName,
    required super.trackSrc,
  });

    factory CallerTonesModel.fromJson(Map<String, dynamic> json) => CallerTonesModel(
        callerTonesId: json["callerTonesId"],
        toneCodeL: json["toneCodeL"],
        toneCodeM: json["toneCodeM"],
        toneName: json["toneName"],
        trackSrc: json["trackSrc"],
    );

    Map<String, dynamic> toJson() => {
        "callerTonesId": callerTonesId,
        "toneCodeL": toneCodeL,
        "toneCodeM": toneCodeM,
        "toneName": toneName,
        "trackSrc": trackSrc,
    };
}
