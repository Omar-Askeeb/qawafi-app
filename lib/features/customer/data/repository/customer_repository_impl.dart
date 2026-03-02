import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/common/models/user_info.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:qawafi_app/features/customer/data/models/wallet_transaction_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/customer_repository.dart';
import '../models/subscription_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDatasource remoteDatasource;

  CustomerRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, SubscriptionModel>> cancelSubscription(
      {required String userId}) async {
    try {
      var authResponse = await remoteDatasource.cancelSubscription(
        userId: userId,
      );

      return right(authResponse);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserInfoModel>> chargeWallet(
      {required String userId, required int cardNo}) async {
    try {
      var authResponse = await remoteDatasource.chargeWallet(
        userId: userId,
        cardNo: cardNo,
      );

      return right(authResponse);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> subscribe(
      {required String userId, required int subscriptionId}) async {
    try {
      var authResponse = await remoteDatasource.subscribe(
        userId: userId,
        subscriptionId: subscriptionId,
      );

      return right(authResponse);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> notificationToken(
      {required String token}) async {
    try {
      var authResponse = await remoteDatasource.notificationToken(
        token: token,
      );

      return right(authResponse);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SubscriptionModel>> mySubscription(
      {required String userId}) async {
    try {
      var response = await remoteDatasource.mySubscription(
        userId: userId,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserInfoModel>> updateUserInfo(
      {required String userId, required String name}) async {
    try {
      var authResponse = await remoteDatasource.updateUserInfo(
        userId: userId,
        name: name,
      );

      return right(authResponse);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
      {required String password, required String newPassword}) async {
    try {
      var response = await remoteDatasource.changePassword(
        password: password,
        newPassword: newPassword,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<WalletTransactionModel>>> fetchTransactions(
      {required String userId}) async {
    try {
      var response = await remoteDatasource.fetchTransactions(
        userId: userId,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
