import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/poem/data/models/poem_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/string_param.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/favorite_repository.dart';

class FetchFavPoems implements UseCase<List<PoemModel>, StringParam> {
  final FavoriteRepository repository;

  FetchFavPoems({required this.repository});
  @override
  Future<Either<Failure, List<PoemModel>>> call(StringParam params) async {
    return await repository.fetchMyPoemFav(userId: params.string);
  }
}
