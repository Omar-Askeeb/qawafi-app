import 'dart:convert';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/features/subscription/data/models/payment_method_model.dart';

import '../../../../core/error/exceptions.dart';

abstract interface class PaymentMethodRemoteDatasource {
  Future<List<PaymentMethodModel>> fetchPaymentMethods();
}

class PaymentMethodRemoteDatasourceImpl
    implements PaymentMethodRemoteDatasource {
  final ApiClient client;

  PaymentMethodRemoteDatasourceImpl({required this.client});
  @override
  Future<List<PaymentMethodModel>> fetchPaymentMethods() async {
    try {
      var response = await client.get(EndPoints.paymentMethod);
      return List<PaymentMethodModel>.from(
        json.decode(utf8.decode(response.bodyBytes))['data']["list"].map(
              (x) => PaymentMethodModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
