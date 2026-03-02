import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/repository/proverbStory_repository.dart';

class GetProverbStories implements UseCase<List<ProverbStory>, GetProverbStoriesParams> {
  final ProverbStoryRepository repository;

  GetProverbStories({required this.repository});

  @override
  Future<Either<Failure, List<ProverbStory>>> call(GetProverbStoriesParams params) async {
    return await repository.getProverbStories(params.pageNumber, params.pageSize);
  }
}

class GetProverbStoriesParams {
  final int pageNumber;
  final int pageSize;

  GetProverbStoriesParams({required this.pageNumber, required this.pageSize});
}

