import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/favorite/data/datasource/favorite_remote_datasource.dart';

import 'package:qawafi_app/features/poem/data/models/poem_model.dart';

import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';

import 'package:qawafi_app/features/storyProverb/data/models/proverbStoryModel.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDatasource remoteDatasource;

  FavoriteRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<PoemModel>>> fetchMyPoemFav(
      {required String userId}) async {
    try {
      return right(await remoteDatasource.fetchMyPoemFav(userId: userId));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProverbStoryModel>>> fetchMyProverbStoryFav(
      {required String userId}) async {
    try {
      return right(
          await remoteDatasource.fetchMyProverbStoryFav(userId: userId));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<QuatrainModel>>> fetchMyQuatrainFav(
      {required String userId}) async {
    try {
      return right(await remoteDatasource.fetchMyQuatrainFav(userId: userId));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
