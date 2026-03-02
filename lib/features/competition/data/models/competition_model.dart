import '../../domain/entities/competition_entity.dart';
import 'contestant_result_model.dart';

class CompetitionModel extends Competition {
  CompetitionModel({
    required super.competitionId,
    required super.competitionName,
    required super.competitionDescription,
    required super.imageSrc,
    required super.endDate,
    required super.isRunning,
    required super.totalNumberOfContestant,
    required super.contestantContentResult,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      competitionId: json['competitionId']?.toString() ?? '',
      competitionName: json['competitionName'] ?? '',
      competitionDescription: json['competitionDescription'] ?? '',
      imageSrc: json['imageSrc'] ?? '',
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      isRunning: json['isRunning'] ?? false,
      totalNumberOfContestant: int.tryParse(json['totalNumberOfContestant']?.toString() ?? '0') ?? 0,
      contestantContentResult: (json['contestantContentResult'] as List<dynamic>?)
              ?.map((e) => ContestantResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competitionId': competitionId,
      'competitionName': competitionName,
      'competitionDescription': competitionDescription,
      'imageSrc': imageSrc,
      'endDate': endDate.toIso8601String(),
      'isRunning': isRunning,
      'totalNumberOfContestant': totalNumberOfContestant,
      'contestantContentResult': contestantContentResult
          .map((e) => (e as ContestantResultModel).toJson())
          .toList(),
    };
  }
}
