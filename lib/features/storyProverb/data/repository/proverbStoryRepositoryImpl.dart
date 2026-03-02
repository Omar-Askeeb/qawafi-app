import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/network/connection_checker.dart';
import 'package:qawafi_app/features/storyProverb/data/datasource/proverbStoryRemoteDataSource.dart';
import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/repository/proverbStory_repository.dart';

class ProverbStoryRepositoryImpl implements ProverbStoryRepository {
  final ProverbStoryRemoteDataSource remoteDataSource;

  ProverbStoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProverbStory>>> getProverbStories(
      int pageNumber, int pageSize) async {
    try {
      final isConnected =
          await ConnectionCheckerImpl(InternetConnection()).isConnected;
      if (!isConnected) {
        // في حالة عدم الاتصال، ارجاع خطأ الاتصال بالإنترنت
        return left(Failure('لا يوجد إتصال بالأنترنت'));
      }

      final remoteStories =
          await remoteDataSource.getProverbStories(pageNumber, pageSize);
      return Right(remoteStories);
    } on ServerException {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> updateFavoriteStatus(
      String id, bool isFavorite) async {
    try {
      await remoteDataSource.updateFavoriteStatus(id, isFavorite);
      return Right(null);
    } on ServerException {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ProverbStory>> getProverbStoriesById(String id) async {
    try {
      final isConnected =
          await ConnectionCheckerImpl(InternetConnection()).isConnected;
      if (!isConnected) {
        // في حالة عدم الاتصال، ارجاع خطأ الاتصال بالإنترنت
        return left(Failure('لا يوجد إتصال بالأنترنت'));
      }

      final remoteStories = await remoteDataSource.getProverbStoryById(id);
      return Right(remoteStories);
    } on ServerException {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ProverbStory>> add2Favorite(
      {required String id}) async {
    try {
      return right(
        await remoteDataSource.add2Favorite(
          id,
        ),
      );
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ProverbStory>> removeFromFavorite(
      {required String id}) async {
    try {
      return right(
        await remoteDataSource.removeFromFavorite(id),
      );
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
