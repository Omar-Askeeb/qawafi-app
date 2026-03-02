import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/competition_repository.dart';

class VoteContestant implements UseCase<bool, String> {
  final CompetitionRepository repository;

  VoteContestant(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.voteContestant(params);
  }
}
