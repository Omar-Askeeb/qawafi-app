import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/poem_id_param.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/poet.dart';
import '../repository/poet_repository.dart';

class FollowPoet implements UseCase<PoetModel, PoemIdParam> {
  final PoetRepositroy poetRepositroy;

  FollowPoet({required this.poetRepositroy});
  @override
  Future<Either<Failure, PoetModel>> call(PoemIdParam params) async {
    return await poetRepositroy.followPoet(params.poetId);
  }
}
