import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/usecase/search_pagination_params.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/quatrain_model.dart';
import '../repository/quatrains_repository.dart';

class FetchQuatrains implements UseCase<List<QuatrainModel>, QuatrainParams> {
  final QuatrainsRepository repository;

  FetchQuatrains({required this.repository});
  @override
  Future<Either<Failure, List<QuatrainModel>>> call(
      QuatrainParams params) async {
    return await repository.fetchQuatrains(
      pageNo: params.pageNo,
      pageSize: params.pageSize,
      categoryId: params.categoryId,
      query: params.query,
    );
  }
}

class QuatrainParams extends SearchPaginationParams {
  final String? categoryId;
  QuatrainParams(
      {required super.pageNo,
      required super.pageSize,
      required this.categoryId,
      required super.query});
}
