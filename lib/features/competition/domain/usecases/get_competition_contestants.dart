import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/competition_entity.dart';
import '../repository/competition_repository.dart';

class GetCompetitionContestants implements UseCase<Competition, String> {
  final CompetitionRepository repository;

  GetCompetitionContestants(this.repository);

  @override
  Future<Either<Failure, Competition>> call(String params) async {
    return await repository.getCompetitionContestants(params);
  }
}
