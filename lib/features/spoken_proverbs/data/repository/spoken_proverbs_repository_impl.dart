import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/datasources/spoken_proverb_remote_datasource.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_category_model.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_model.dart';
import 'package:qawafi_app/features/spoken_proverbs/domain/repository/spoken_proverbs_repository.dart';

import '../../../../core/error/exceptions.dart';

class SpokenProverbRepositoryImpl implements SpokenProverbRepository {
  final SpokenProverbRemoteDatasource repository;

  SpokenProverbRepositoryImpl({required this.repository});
  @override
  Future<Either<Failure, List<SpokenProverbCategoryModel>>>
      fetchCategories() async {
    try {
      return right(await repository.fetchCategories());
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SpokenProverbModel>>>
      fetchSpokenProverbByCategory({required String categoryId}) async {
    try {
      return right(await repository.fetchSpokenProverbByCategory(
          categoryId: categoryId));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
