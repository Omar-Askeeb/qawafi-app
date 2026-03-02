import 'package:flutter/foundation.dart';

@immutable
sealed class CompetitionEvent {}

final class GetCompetitionsEvent extends CompetitionEvent {}

final class RefreshCompetitionsEvent extends CompetitionEvent {}

final class GetCompetitionContestantsEvent extends CompetitionEvent {
  final String id;
  GetCompetitionContestantsEvent(this.id);
}

final class VoteContestantEvent extends CompetitionEvent {
  final String trackId;
  final String competitionId;
  VoteContestantEvent(this.trackId, this.competitionId);
}

final class UnVoteContestantEvent extends CompetitionEvent {
  final String trackId;
  final String competitionId;
  UnVoteContestantEvent(this.trackId, this.competitionId);
}
