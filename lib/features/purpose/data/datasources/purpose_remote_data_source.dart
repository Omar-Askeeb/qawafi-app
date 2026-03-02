import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/purpose/data/models/purpose_model.dart';

abstract interface class PurposeRemoteDatasource {
  Future<List<PurposeModel>> fetchPurposeAll();
}

class PurposeRemoteDatasourceImpl implements PurposeRemoteDatasource {
  final ApiClient client;

  PurposeRemoteDatasourceImpl({required this.client});
  @override
  Future<List<PurposeModel>> fetchPurposeAll() async {
    try {
      var res = await client.get(
        EndPoints.fetchPurposeAll,
      );

      return List<PurposeModel>.from(
        json.decode(utf8.decode(res.bodyBytes))["data"].map(
              (x) => PurposeModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
