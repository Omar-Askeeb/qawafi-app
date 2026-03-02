import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/ads/data/models/advertisement_model.dart';

abstract interface class AdvertisementRemoteDatasource {
  Future<List<AdvertisementModel>> fetchAdversiments();
}

class AdvertisementRemoteDatasourceImpl
    implements AdvertisementRemoteDatasource {
  final ApiClient client;

  AdvertisementRemoteDatasourceImpl({required this.client});
  @override
  Future<List<AdvertisementModel>> fetchAdversiments() async {
    try {
      var response = await client.get(EndPoints.advertisement);
      return List<AdvertisementModel>.from(
        json
            .decode(
              utf8.decode(response.bodyBytes),
            )['data']["list"]
            .map(
              (x) => AdvertisementModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
