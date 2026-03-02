import '../entities/proverbStory.dart';
import '/../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';



abstract class ProverbStoryRepository {
  Future<Either<Failure, List<ProverbStory>>> getProverbStories(int pageNumber, int pageSize);
  Future<Either<Failure, void>> updateFavoriteStatus(String id, bool isFavorite);
  Future<Either<Failure, ProverbStory>> getProverbStoriesById(String id);
  Future<Either<Failure, ProverbStory>> add2Favorite({
    required String id,
  });

  Future<Either<Failure, ProverbStory>> removeFromFavorite({
    required String id,
  });
}