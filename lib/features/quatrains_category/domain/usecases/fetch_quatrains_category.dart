import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/quatrains_category/data/models/quatrains_category_model.dart';
import 'package:qawafi_app/features/quatrains_category/domain/repository/quartrains_category_repository.dart';

import '../../../../core/usecase/search_pagination_params.dart';

class FetchQuatrainsCategory
    implements UseCase<List<QuatrainsCategoryModel>, SearchPaginationParams> {
  final QuatrainsCategoryRepository repository;

  FetchQuatrainsCategory({required this.repository});
  @override
  Future<Either<Failure, List<QuatrainsCategoryModel>>> call(
      SearchPaginationParams params) async {
    // TODO: implement call
    return await repository.fetchQuatrainsCategory(
        pageNo: params.pageNo, pageSize: params.pageSize, query: params.query);
  }
}
