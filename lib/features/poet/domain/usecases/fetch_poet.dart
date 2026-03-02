import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';
import 'package:qawafi_app/features/poet/domain/repository/poet_repository.dart';

class FetchPoet implements UseCase<PoetModel, FetchPoetParams> {
  final PoetRepositroy poetRepositroy;

  FetchPoet({required this.poetRepositroy});
  @override
  Future<Either<Failure, PoetModel>> call(FetchPoetParams params) async {
    return await poetRepositroy.getPoet(params.poetId);
  }
}

class FetchPoetParams {
  final String poetId;

  FetchPoetParams({required this.poetId});
}
