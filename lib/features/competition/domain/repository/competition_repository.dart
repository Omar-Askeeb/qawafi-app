import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/competition_entity.dart';

abstract interface class CompetitionRepository {
  Future<Either<Failure, List<Competition>>> getCompetitions();
  Future<Either<Failure, Competition>> getCompetitionContestants(String id);
  Future<Either<Failure, bool>> voteContestant(String trackId);
  Future<Either<Failure, bool>> unVoteContestant(String trackId);
}
