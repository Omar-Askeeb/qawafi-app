import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';

import '../../../../core/usecase/poem_id_param.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/poet.dart';
import '../repository/poet_repository.dart';

class UnFollowPoet implements UseCase<PoetModel, PoemIdParam> {
  final PoetRepositroy poetRepositroy;

  UnFollowPoet({required this.poetRepositroy});
  @override
  Future<Either<Failure, PoetModel>> call(PoemIdParam params) async {
    return await poetRepositroy.unFollowPoet(params.poetId);
  }
}
