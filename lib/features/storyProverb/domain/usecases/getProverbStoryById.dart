import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/repository/proverbStory_repository.dart';

class GetProverbStoriesById
    implements UseCase<ProverbStory, GetProverbStoriesByIdParams> {
  final ProverbStoryRepository repository;

  GetProverbStoriesById({required this.repository});

  @override
  Future<Either<Failure, ProverbStory>> call(
      GetProverbStoriesByIdParams params) async {
    return await repository.getProverbStoriesById(
        params.id.toString());
  }
}

class GetProverbStoriesByIdParams {
  final String id;

  GetProverbStoriesByIdParams({required this.id});
}
