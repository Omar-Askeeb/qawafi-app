import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/quatrains/data/datasources/quatrains_remote_datasource.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/quatrains_repository.dart';

class QuatrainsRepositoryImpl implements QuatrainsRepository {
  final QuatrainsRemoteDatasource remoteDatasource;

  QuatrainsRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, QuatrainModel>> add2Favorite(
      {required String? id}) async {
    try {
      return right(
        await remoteDatasource.add2Favorite(
          id: id,
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
  Future<Either<Failure, QuatrainModel>> fetchQuatrainById(
      {required String? id}) async {
    try {
      return right(
        await remoteDatasource.fetchQuatrainById(
          id: id,
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
  Future<Either<Failure, List<QuatrainModel>>> fetchQuatrains(
      {required int pageNo,
      required int pageSize,
      String? query,
      required String? categoryId}) async {
    try {
      return right(
        await remoteDatasource.fetchQuatrains(
          pageNo: pageNo,
          pageSize: pageSize,
          query: query,
          categoryId: categoryId,
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
  Future<Either<Failure, QuatrainModel>> removeFromFavorite(
      {required String? id}) async {
    try {
      return right(
        await remoteDatasource.removeFromFavorite(
          id: id,
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
}
