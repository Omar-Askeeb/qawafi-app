import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';

import '../../data/models/poem_model.dart';
import '../repository/poem_repository.dart';

class GetPoemById implements UseCase<PoemModel, StringParam> {
  final PoemRepository poemRepository;

  GetPoemById({required this.poemRepository});

  @override
  Future<Either<Failure, PoemModel>> call(StringParam params) {
    // TODO: implement call
    return poemRepository.getPoemById(id: params.string);
  }
}
