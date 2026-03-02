import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';

import '../../../../core/error/failures.dart';

abstract interface class PoetRepositroy {
  Future<Either<Failure, List<PoetModel>>> getPoets({
    String? query,
    required int pageNo,
    required int pageSize,
  });
  Future<Either<Failure, PoetModel>> getPoet(String poetId);
  Future<Either<Failure, PoetModel>> followPoet(String poetId);
  Future<Either<Failure, PoetModel>> unFollowPoet(String poetId);
}
