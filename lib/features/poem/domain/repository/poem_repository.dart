import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';

import '../../../../core/enums/search_keys.dart';
import '../../data/models/poem_model.dart';

abstract interface class PoemRepository {
  Future<Either<Failure, PoemDataModel>> getPoemByPurposeAndCategory({
    required String purpose,
    required String poemCategory,
    required int pageNo,
    required int pageSize,
  });

  Future<Either<Failure, PoemDataModel>> getPoemByMelodyOrJustRecite({
    required String poemCategory,
    required String? melody,
  });

  Future<Either<Failure, PoemDataModel>> getPoemByPoetId({
    required String poetId,
  });

  Future<Either<Failure, PoemModel>> getPoemById({
    required String id,
  });

  Future<Either<Failure, PoemDataModel>> poemMostStreamed();

  Future<Either<Failure, PoemDataModel>> poemNewest();
  Future<Either<Failure, PoemDataModel>> searchPoems({
    required SearchKeys searchKey,
    required String searchValue,
    required int pageNo,
    required int pageSize,
  });

  Future<Either<Failure, PoemModel>> add2Favorite({
    required String poemId,
  });

  Future<Either<Failure, PoemModel>> remove2Favorite({
    required String poemId,
  });
}
