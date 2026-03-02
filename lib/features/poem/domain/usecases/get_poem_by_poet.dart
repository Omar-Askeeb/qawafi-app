import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/domain/repository/poem_repository.dart';

class GetPoemByPoetId implements UseCase<PoemDataModel, GetPoemByPoetIdParams> {
  final PoemRepository poemRepository;

  GetPoemByPoetId({required this.poemRepository});
  @override
  Future<Either<Failure, PoemDataModel>> call(
      GetPoemByPoetIdParams params) async {
    return await poemRepository.getPoemByPoetId(poetId: params.poetId);
  }
}

class GetPoemByPoetIdParams {
  final String poetId;

  GetPoemByPoetIdParams({required this.poetId});
}
