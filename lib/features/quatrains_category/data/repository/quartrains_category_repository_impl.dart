import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/quatrains_category/data/datasources/quartrains_category_remote_datasource.dart';

import 'package:qawafi_app/features/quatrains_category/data/models/quatrains_category_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/quartrains_category_repository.dart';

class QuatrainsCategoryRepositoryImpl implements QuatrainsCategoryRepository {
  final QuatrainsCategoryRemoteDatasource remoteDatasource;

  QuatrainsCategoryRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<QuatrainsCategoryModel>>> fetchQuatrainsCategory({
    required int pageNo,
    required int pageSize,
    String? query,
  }) async {
    try {
      return right(
        await remoteDatasource.fetchQuatrainsCategory(
          pageNo: pageNo,
          pageSize: pageSize,
          query: query,
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
