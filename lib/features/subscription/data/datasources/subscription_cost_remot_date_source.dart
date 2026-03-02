import 'dart:convert';

import 'package:qawafi_app/features/subscription/data/models/subscription_cost_model.dart';

import '../../../../core/api/api_client2.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';

abstract interface class CostRemoteDatasource {
  Future<List<SubscriptionCostModel>> fetchCosts(
      {int? period, int? paymentMethodId});
}

class CostRemoteDatasourceImpl implements CostRemoteDatasource {
  final ApiClient client;

  CostRemoteDatasourceImpl({required this.client});
  @override
  Future<List<SubscriptionCostModel>> fetchCosts(
      {int? period, int? paymentMethodId}) async {
    // TODO: implement fetchCost
    try {
      var response = await client.get(EndPoints.subscriptionCost);
      return List<SubscriptionCostModel>.from(
        json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
              (x) => SubscriptionCostModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
