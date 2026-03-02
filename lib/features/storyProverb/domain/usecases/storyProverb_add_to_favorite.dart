import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/repository/proverbStory_repository.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/storyProverpParm.dart';

class StoryProverbAdd2Favorite
    implements UseCase<ProverbStory, StoryProverbIdParam> {
  final ProverbStoryRepository repository;

  StoryProverbAdd2Favorite({required this.repository});
  @override
  Future<Either<Failure, ProverbStory>> call(StoryProverbIdParam params) async {
    return await repository.add2Favorite(id: params.id);
  }
}
