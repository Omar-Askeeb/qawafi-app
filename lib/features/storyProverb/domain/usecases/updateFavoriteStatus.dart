import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/storyProverb/domain/repository/proverbStory_repository.dart';

class UpdateFavoriteStatus implements UseCase<void, FavoriteParams> {
  final ProverbStoryRepository repository;

  UpdateFavoriteStatus({required this.repository});

  @override
  Future<Either<Failure, void>> call(FavoriteParams params) async {
    return await repository.updateFavoriteStatus(params.id, params.isFavorite);
  }
}

class FavoriteParams {
  final String id;
  final bool isFavorite;

  FavoriteParams({required this.id, required this.isFavorite});
}

