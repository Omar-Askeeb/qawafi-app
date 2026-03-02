import 'dart:convert';

import 'package:qawafi_app/features/quatrains_category/data/models/quatrains_category_model.dart';

import '../../../../core/api/api_client2.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';

abstract interface class QuatrainsCategoryRemoteDatasource {
  Future<List<QuatrainsCategoryModel>> fetchQuatrainsCategory({
    required int pageNo,
    required int pageSize,
    String? query,
  });
}

class QuatrainsCategoryRemoteDatasourceImpl
    implements QuatrainsCategoryRemoteDatasource {
  final ApiClient client;

  QuatrainsCategoryRemoteDatasourceImpl({required this.client});

  @override
  Future<List<QuatrainsCategoryModel>> fetchQuatrainsCategory({
    required int pageNo,
    required int pageSize,
    String? query,
  }) async {
    try {
      var res = await client.get(
        EndPoints.fetchQuatrainsCategory +
            '?pageNumber=$pageNo&pageSize=$pageSize&search=${query ?? ''}',
      );

      return List<QuatrainsCategoryModel>.from(
        json.decode(utf8.decode(res.bodyBytes))["data"]['list'].map(
              (x) => QuatrainsCategoryModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
