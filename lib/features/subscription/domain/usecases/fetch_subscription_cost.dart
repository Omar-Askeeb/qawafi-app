import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/subscription/data/models/subscription_cost_model.dart';
import 'package:qawafi_app/features/subscription/domain/repository/subscription_cost_repository.dart';

class FetchSubscriptionCost
    implements
        UseCase<List<SubscriptionCostModel>, FetchSubscriptionCostParams> {
  final SubscriptionCostRepository repository;

  FetchSubscriptionCost({required this.repository});
  @override
  Future<Either<Failure, List<SubscriptionCostModel>>> call(
      FetchSubscriptionCostParams params) async {
    return await repository.fetchCosts(
      paymentMethodId: params.paymentMethodId,
      periodId: params.subscriptionPeriodId,
    );
  }
}

class FetchSubscriptionCostParams {
  final int? subscriptionPeriodId;
  final int? paymentMethodId;

  FetchSubscriptionCostParams(
      {this.subscriptionPeriodId, this.paymentMethodId});
}
