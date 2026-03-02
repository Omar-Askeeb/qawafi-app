import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/poem_id_param.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';

import '../../data/models/poem_model.dart';
import '../repository/poem_repository.dart';

class Remove2Favorite implements UseCase<PoemModel, PoemIdParam> {
  final PoemRepository poemRepository;

  Remove2Favorite({required this.poemRepository});

  @override
  Future<Either<Failure, PoemModel>> call(PoemIdParam params) {
    // TODO: implement call
    return poemRepository.remove2Favorite(poemId: params.poetId);
  }
}
