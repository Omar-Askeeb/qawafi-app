import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/quatrain_model.dart';

abstract interface class QuatrainsRepository {
  Future<Either<Failure, List<QuatrainModel>>> fetchQuatrains({
    required int pageNo,
    required int pageSize,
    required String? categoryId,
    String? query,
  });

  Future<Either<Failure, QuatrainModel>> fetchQuatrainById({
    required String? id,
  });

  Future<Either<Failure, QuatrainModel>> add2Favorite({
    required String? id,
  });

  Future<Either<Failure, QuatrainModel>> removeFromFavorite({
    required String? id,
  });
}
