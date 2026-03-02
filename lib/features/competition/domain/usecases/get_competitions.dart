import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/competition_entity.dart';
import '../repository/competition_repository.dart';

class GetCompetitions implements UseCase<List<Competition>, NoParams> {
  final CompetitionRepository repository;

  GetCompetitions(this.repository);

  @override
  Future<Either<Failure, List<Competition>>> call(NoParams params) async {
    return await repository.getCompetitions();
  }
}
