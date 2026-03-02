import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/quatrain_model.dart';
import '../repository/quatrains_repository.dart';
import 'quatrain_id_param.dart';

class QuatrainRemoveFromFavorite
    implements UseCase<QuatrainModel, QuatrianIdParam> {
  final QuatrainsRepository repository;

  QuatrainRemoveFromFavorite({required this.repository});
  @override
  Future<Either<Failure, QuatrainModel>> call(QuatrianIdParam params) async {
    return await repository.removeFromFavorite(id: params.id);
  }
}
