import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/favorite/domain/repository/favorite_repository.dart';

import '../../../quatrains/data/models/quatrain_model.dart';

class FetchFavQuatrains implements UseCase<List<QuatrainModel>, StringParam> {
  final FavoriteRepository repository;

  FetchFavQuatrains({required this.repository});
  @override
  Future<Either<Failure, List<QuatrainModel>>> call(StringParam params) async {
    return await repository.fetchMyQuatrainFav(userId: params.string);
  }
}
