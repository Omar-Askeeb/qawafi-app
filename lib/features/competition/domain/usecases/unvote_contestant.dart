import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/competition_repository.dart';

class UnVoteContestant implements UseCase<bool, String> {
  final CompetitionRepository repository;

  UnVoteContestant(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.unVoteContestant(params);
  }
}
