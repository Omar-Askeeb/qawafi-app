import 'package:fpdart/fpdart.dart';

import '../../../../core/common/models/user_info.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/wallet_transaction_model.dart';
import '../../data/models/subscription_model.dart';

abstract interface class CustomerRepository {
  Future<Either<Failure, void>> subscribe(
      {required String userId, required int subscriptionId});
  Future<Either<Failure, void>> notificationToken({required String token});

  Future<Either<Failure, SubscriptionModel>> cancelSubscription({
    required String userId,
  });
  Future<Either<Failure, List<WalletTransactionModel>>> fetchTransactions({
    required String userId,
  });

  Future<Either<Failure, String>> changePassword({
    required String password,
    required String newPassword,
  });

  Future<Either<Failure, UserInfoModel>> updateUserInfo({
    required String userId,
    required String name,
  });
  Future<Either<Failure, SubscriptionModel>> mySubscription({
    required String userId,
  });
  Future<Either<Failure, UserInfoModel>> chargeWallet({
    required String userId,
    required int cardNo,
  });
}
