import 'package:flutter/foundation.dart';
import '../../domain/entities/competition_entity.dart';

@immutable
sealed class CompetitionState {}

final class CompetitionInitial extends CompetitionState {}

final class CompetitionLoading extends CompetitionState {}

final class CompetitionSuccess extends CompetitionState {
  final List<Competition> competitions;

  CompetitionSuccess(this.competitions);
}

final class CompetitionFailure extends CompetitionState {
  final String message;

  CompetitionFailure(this.message);
}

final class CompetitionContestantsSuccess extends CompetitionState {
  final Competition competition;
  final String? conflictMessage;
  CompetitionContestantsSuccess(this.competition, {this.conflictMessage});
}
