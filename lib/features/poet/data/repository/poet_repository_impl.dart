import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/poet/data/datasources/poet_remote_datasource.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repository/poet_repository.dart';

class PoetRepositroyImpl implements PoetRepositroy {
  final PoetRemoteDatasource remoteDataSource;

  PoetRepositroyImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<PoetModel>>> getPoets({
    String? query,
    required int pageNo,
    required int pageSize,
  }) async {
    try {
      return right(await remoteDataSource.FetchPoets(
          pageNo: pageNo, pageSize: pageSize, query: query));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PoetModel>> getPoet(String poetId) async {
    try {
      return right(await remoteDataSource.FetchPoet(poetId));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PoetModel>> followPoet(String poetId) async {
    try {
      return right(await remoteDataSource.followPoet(poetId));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PoetModel>> unFollowPoet(String poetId) async {
    try {
      return right(await remoteDataSource.unFollowPoet(poetId));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
