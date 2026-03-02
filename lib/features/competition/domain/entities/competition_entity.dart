import 'contestant_result_entity.dart';

class Competition {
  final String competitionId;
  final String competitionName;
  final String competitionDescription;
  final String imageSrc;
  final DateTime endDate;
  final bool isRunning;
  final int totalNumberOfContestant;
  final List<ContestantResult> contestantContentResult;

  Competition({
    required this.competitionId,
    required this.competitionName,
    required this.competitionDescription,
    required this.imageSrc,
    required this.endDate,
    required this.isRunning,
    required this.totalNumberOfContestant,
    required this.contestantContentResult,
  });
}
