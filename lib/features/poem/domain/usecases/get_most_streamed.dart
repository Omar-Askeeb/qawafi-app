import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';

import '../repository/poem_repository.dart';

class GetMostStreamed implements UseCase<PoemDataModel, NoParams> {
  final PoemRepository poemRepository;

  GetMostStreamed({required this.poemRepository});

  @override
  Future<Either<Failure, PoemDataModel>> call(NoParams params) async {
    return await poemRepository.poemMostStreamed();
  }
}
