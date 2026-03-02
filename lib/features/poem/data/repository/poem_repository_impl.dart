import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/enums/search_keys.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/poem/data/datasources/poem_remote_data_source.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/domain/repository/poem_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../models/poem_model.dart';

class PoemRepositoryImpl implements PoemRepository {
  final PoemRemoteDatasource remoteDatasource;

  PoemRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, PoemDataModel>> getPoemByMelodyOrJustRecite({
    required String poemCategory,
    required String? melody,
  }) async {
    try {
      return right(
        await remoteDatasource.getPoemByMelodyOrJustRecite(
          poemCategory: poemCategory,
          melody: melody,
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
  Future<Either<Failure, PoemDataModel>> getPoemByPurposeAndCategory({
    required String purpose,
    required String poemCategory,
    required int pageNo,
    required int pageSize,
  }) async {
    try {
      return right(
        await remoteDatasource.getPoemByPurposeAndCategory(
          poemCategory: poemCategory,
          purpose: purpose,
          pageNo: pageNo,
          pageSize: pageSize,
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
  Future<Either<Failure, PoemDataModel>> poemMostStreamed() async {
    try {
      return right(
        await remoteDatasource.getMostStreamed(),
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
  Future<Either<Failure, PoemDataModel>> poemNewest() async {
    try {
      return right(
        await remoteDatasource.getNewest(),
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
  Future<Either<Failure, PoemDataModel>> getPoemByPoetId(
      {required String poetId}) async {
    try {
      return right(
        await remoteDatasource.getPoemByPoetId(poetId: poetId),
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
  Future<Either<Failure, PoemDataModel>> searchPoems({
    required SearchKeys searchKey,
    required String searchValue,
    required int pageNo,
    required int pageSize,
  }) async {
    // TODO: implement searchPoems
    try {
      return right(
        await remoteDatasource.searchPoems(
          searchKey: searchKey,
          searchValue: searchValue,
          pageNo: pageNo,
          pageSize: pageSize,
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
  Future<Either<Failure, PoemModel>> add2Favorite(
      {required String poemId}) async {
    try {
      return right(
        await remoteDatasource.add2Favorite(poemId: poemId),
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
  Future<Either<Failure, PoemModel>> remove2Favorite(
      {required String poemId}) async {
    try {
      return right(
        await remoteDatasource.remove2Favorite(poemId: poemId),
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
  Future<Either<Failure, PoemModel>> getPoemById({required String id}) async {
    try {
      return right(
        await remoteDatasource.getPoemById(id: id),
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
