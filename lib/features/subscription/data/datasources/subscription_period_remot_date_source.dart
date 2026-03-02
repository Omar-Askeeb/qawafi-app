import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/subscription/data/models/subscription_period_model.dart';

abstract interface class PeriodRemoteDatasource {
  Future<List<SubscriptionPeriodModel>> fetchPeriods();
}

class PeriodRemoteDatasourceImpl implements PeriodRemoteDatasource {
  final ApiClient client;

  PeriodRemoteDatasourceImpl({required this.client});
  @override
  Future<List<SubscriptionPeriodModel>> fetchPeriods() async {
    // TODO: implement fetchCost
    try {
      var response = await client.get(EndPoints.subscriptionPeriod);
      return List<SubscriptionPeriodModel>.from(
        json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
              (x) => SubscriptionPeriodModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
