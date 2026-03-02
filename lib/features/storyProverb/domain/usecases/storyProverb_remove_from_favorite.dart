import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/repository/proverbStory_repository.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/storyProverpParm.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class StoryProverbRemoveFromFavorite
    implements UseCase<ProverbStory, StoryProverbIdParam> {
  final ProverbStoryRepository repository;

  StoryProverbRemoveFromFavorite({required this.repository});
  @override
  Future<Either<Failure, ProverbStory>> call(StoryProverbIdParam params) async {
    return await repository.removeFromFavorite(id: params.id);
  }
}
