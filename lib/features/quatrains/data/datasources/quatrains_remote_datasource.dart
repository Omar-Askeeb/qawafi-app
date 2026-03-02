import 'dart:convert';

import '../../../../core/api/api_client2.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../models/quatrain_model.dart';

abstract interface class QuatrainsRemoteDatasource {
  Future<List<QuatrainModel>> fetchQuatrains(
      {required int pageNo,
      required int pageSize,
      String? query,
      required String? categoryId});

  Future<QuatrainModel> fetchQuatrainById({
    required String? id,
  });

  Future<QuatrainModel> add2Favorite({
    required String? id,
  });

  Future<QuatrainModel> removeFromFavorite({
    required String? id,
  });
}

class QuatrainsRemoteDatasourceImpl implements QuatrainsRemoteDatasource {
  final ApiClient client;

  QuatrainsRemoteDatasourceImpl({required this.client});

  @override
  Future<QuatrainModel> add2Favorite({required String? id}) async {
    try {
      var res = await client.post(EndPoints.quatrainsAdd2Favorite,
          body: jsonEncode({'quatrainsId': id}));
      return QuatrainModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))["data"]);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<QuatrainModel> fetchQuatrainById({required String? id}) async {
    try {
      var res = await client.get(
        '${EndPoints.fetchQuatrains}/$id',
      );

      return QuatrainModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))["data"]);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<List<QuatrainModel>> fetchQuatrains(
      {required int pageNo,
      required int pageSize,
      String? query,
      required String? categoryId}) async {
    try {
      var res = await client.get(
        EndPoints.fetchQuatrains +
            '?pageNumber=$pageNo&pageSize=$pageSize&search=${query ?? ''}&categoryId=${categoryId ?? ''}',
      );

      return List<QuatrainModel>.from(
        json.decode(utf8.decode(res.bodyBytes))["data"]['list'].map(
              (x) => QuatrainModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<QuatrainModel> removeFromFavorite({required String? id}) async {
    try {
      var res = await client.post(EndPoints.quatrainsRemoveFromFavorite,
          body: jsonEncode({'quatrainsId': id}));
      return QuatrainModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))["data"]);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
