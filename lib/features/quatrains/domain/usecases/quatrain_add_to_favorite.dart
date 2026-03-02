import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';
import 'package:qawafi_app/features/quatrains/domain/repository/quatrains_repository.dart';

import 'quatrain_id_param.dart';

class QuatrainAdd2Favorite implements UseCase<QuatrainModel, QuatrianIdParam> {
  final QuatrainsRepository repository;

  QuatrainAdd2Favorite({required this.repository});
  @override
  Future<Either<Failure, QuatrainModel>> call(QuatrianIdParam params) async {
    return await repository.add2Favorite(id: params.id);
  }
}
