import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/purpose/domain/entites/purpose.dart';
import 'package:qawafi_app/features/purpose/domain/repository/purpose_repository.dart';

class FetchPurposeAll implements UseCase<List<Purpose>, NoParams> {
  final PurposeRepository purposeRepository;

  FetchPurposeAll({required this.purposeRepository});
  @override
  Future<Either<Failure, List<Purpose>>> call(void params) async {
    // TODO: implement call
    return await purposeRepository.fetchPurposeAll();
  }
}
