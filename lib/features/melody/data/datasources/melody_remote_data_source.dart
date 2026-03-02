import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/features/melody/data/models/melody_model.dart';

import '../../../../core/error/exceptions.dart';

abstract interface class MelodyRmoteDatasource {
  Future<List<MelodyModel>> getMelodies();
}

class MelodyRmoteDatasourceImpl implements MelodyRmoteDatasource {
  final ApiClient client;

  MelodyRmoteDatasourceImpl({required this.client});
  @override
  Future<List<MelodyModel>> getMelodies() async {
    try {
      var response = await client.get(EndPoints.getMelodies);
      return List<MelodyModel>.from(
        json.decode(utf8.decode(response.bodyBytes))['data'].map(
              (x) => MelodyModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
