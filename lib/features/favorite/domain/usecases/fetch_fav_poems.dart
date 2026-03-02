import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/storyProverb/data/models/proverbStoryModel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/string_param.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/favorite_repository.dart';

class FetchFavProverbs
    implements UseCase<List<ProverbStoryModel>, StringParam> {
  final FavoriteRepository repository;

  FetchFavProverbs({required this.repository});
  @override
  Future<Either<Failure, List<ProverbStoryModel>>> call(
      StringParam params) async {
    return await repository.fetchMyProverbStoryFav(userId: params.string);
  }
}
