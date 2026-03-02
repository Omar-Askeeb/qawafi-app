import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import '../../domain/entities/competition_entity.dart';
import '../../domain/repository/competition_repository.dart';
import '../datasources/competition_remote_data_source.dart';

class CompetitionRepositoryImpl implements CompetitionRepository {
  final CompetitionRemoteDataSource remoteDataSource;

  CompetitionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Competition>>> getCompetitions() async {
    try {
      final competitions = await remoteDataSource.getCompetitions();
      return right(competitions);
    } on ServerException catch (e) {
      return left(Failure(e.message ?? 'Unknown server error'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Competition>> getCompetitionContestants(String id) async {
    try {
      final competition = await remoteDataSource.getCompetitionContestants(id);
      return right(competition);
    } on ServerException catch (e) {
      return left(Failure(e.message ?? 'Unknown server error'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, bool>> voteContestant(String trackId) async {
    try {
      final result = await remoteDataSource.voteContestant(trackId);
      return right(result);
    } on ConflictException catch (e) {
      return left(ConflictFailure(e.message ?? 'Unknown conflict error'));
    } on ServerException catch (e) {
      return left(Failure(e.message ?? 'Unknown server error'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> unVoteContestant(String trackId) async {
    try {
      final result = await remoteDataSource.unVoteContestant(trackId);
      return right(result);
    } on ConflictException catch (e) {
      return left(ConflictFailure(e.message ?? 'Unknown conflict error'));
    } on ServerException catch (e) {
      return left(Failure(e.message ?? 'Unknown server error'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
