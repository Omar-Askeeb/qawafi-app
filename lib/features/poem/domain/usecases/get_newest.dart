import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/poem_data_model.dart';
import '../repository/poem_repository.dart';

class GetNewest implements UseCase<PoemDataModel, NoParams> {
  final PoemRepository poemRepository;

  GetNewest({required this.poemRepository});

  @override
  Future<Either<Failure, PoemDataModel>> call(NoParams params) async {
    return await poemRepository.poemNewest();
  }
}
