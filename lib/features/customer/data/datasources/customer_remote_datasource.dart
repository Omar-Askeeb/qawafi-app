import 'dart:convert';
import 'dart:developer';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/common/models/user_info.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/customer/data/models/wallet_transaction_model.dart';

import '../models/subscription_model.dart';

abstract interface class CustomerRemoteDatasource {
  Future<void> subscribe({
    required String userId,
    required int subscriptionId,
  });
  Future<void> notificationToken({required String token});

  Future<SubscriptionModel> cancelSubscription({
    required String userId,
  });
  Future<String> changePassword({
    required String password,
    required String newPassword,
  });

  Future<UserInfoModel> updateUserInfo({
    required String userId,
    required String name,
  });

  Future<List<WalletTransactionModel>> fetchTransactions({
    required String userId,
  });

  Future<SubscriptionModel> mySubscription({
    required String userId,
  });
  Future<UserInfoModel> chargeWallet({
    required String userId,
    required int cardNo,
  });
}

class CustomerRemoteDatasourceImpl implements CustomerRemoteDatasource {
  final ApiClient client;

  CustomerRemoteDatasourceImpl({required this.client});
  @override
  Future<void> subscribe(
      {required String userId, required int subscriptionId}) async {
    try {
      await client.put(
        EndPoints.customerSubscribe.replaceFirst("{userId}", userId),
        body: jsonEncode(
          {
            "subscriptionCostId": subscriptionId,
            "otp": "",
          },
        ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<SubscriptionModel> cancelSubscription({required String userId}) async {
    try {
      var response = await client.put(
        EndPoints.customerCancelSubscription.replaceFirst("{userId}", userId),
        body: jsonEncode(
          {},
        ),
      );

      return SubscriptionModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<UserInfoModel> chargeWallet(
      {required String userId, required int cardNo}) async {
    try {
      var response = await client.put(
        EndPoints.customerChargeWallet.replaceFirst("{userId}", userId),
        body: jsonEncode({"cardNumber": cardNo}),
      );

      return UserInfoModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<void> notificationToken({required String token, required}) async {
    try {
      await client.put(
        EndPoints.notificationToken,
        body: jsonEncode(
          {
            "token": token,
          },
        ),
      );
      log(
        EndPoints.notificationToken +
            "  " +
            jsonEncode(
              {
                "token": token,
              },
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<SubscriptionModel> mySubscription({required String userId}) async {
    try {
      var response = await client.get(
        EndPoints.mySubscription.replaceFirst("{userId}", userId),
      );

      return SubscriptionModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<UserInfoModel> updateUserInfo(
      {required String userId, required String name}) async {
    try {
      var response = await client.put(
        EndPoints.updateUserInfo.replaceFirst("{userId}", userId),
        body: jsonEncode({"fullName": name}),
      );

      return UserInfoModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<String> changePassword(
      {required String password, required String newPassword}) async {
    try {
      await client.post(
        EndPoints.changePassword,
        body: jsonEncode({
          "currentPassword": password,
          "newPassword": newPassword,
        }),
      );

      return "تم تغيير كلمة المرور بنجاح";
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<List<WalletTransactionModel>> fetchTransactions(
      {required String userId}) async {
    try {
      var response = await client.get(
        EndPoints.walletTransactions.replaceAll('{userId}', userId),
      );
      return List<WalletTransactionModel>.from(
        json
            .decode(
              utf8.decode(response.bodyBytes),
            )['data']["list"]
            .map(
              (x) => WalletTransactionModel.fromJson(x),
            ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
