import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/quatrains_category_model.dart';

abstract interface class QuatrainsCategoryRepository {
  Future<Either<Failure, List<QuatrainsCategoryModel>>> fetchQuatrainsCategory({
    required int pageNo,
    required int pageSize,
    String? query,
  });
}
