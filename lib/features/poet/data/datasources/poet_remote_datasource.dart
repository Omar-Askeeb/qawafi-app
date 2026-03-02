import 'dart:convert';
import 'dart:developer';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';

abstract interface class PoetRemoteDatasource {
  Future<List<PoetModel>> FetchPoets({
    String? query,
    required int pageNo,
    required int pageSize,
  });
  Future<PoetModel> FetchPoet(String poetId);

  Future<PoetModel> followPoet(String poetId);

  Future<PoetModel> unFollowPoet(String poetId);
}

class PoetRemoteDatasourceImpl implements PoetRemoteDatasource {
  final ApiClient apiClient;

  PoetRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<PoetModel> FetchPoet(String poetId) async {
    // TODO: implement FetchPoet
    try {
      var res = await apiClient.get(EndPoints.fetchPoet + poetId);
      return PoetModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))['data']);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<List<PoetModel>> FetchPoets({
    String? query,
    required int pageNo,
    required int pageSize,
  }) async {
    // TODO: implement FetchPoets
    try {
      String queryParam = query != null ? "&name=$query" : '';
      var res = await apiClient.get(
        EndPoints.fetchPoets +
            '?pageNumber=$pageNo&pageSize=$pageSize$queryParam',
      );
      log(json.decode(utf8.decode(res.bodyBytes))["data"].toString());
      return List<PoetModel>.from(
        json.decode(utf8.decode(res.bodyBytes))['data'].map(
              (x) => PoetModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoetModel> followPoet(String poetId) async {
    // TODO: implement followPoet
    try {
      var res = await apiClient.post(
        EndPoints.followPoet,
        body: jsonEncode({'poetId': poetId}),
      );
      return PoetModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))['data']);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<PoetModel> unFollowPoet(String poetId) async {
    // TODO: implement followPoet
    try {
      var res = await apiClient.post(
        EndPoints.unFollowPoet,
        body: jsonEncode({'poetId': poetId}),
      );
      return PoetModel.fromJson(
          json.decode(utf8.decode(res.bodyBytes))['data']);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
