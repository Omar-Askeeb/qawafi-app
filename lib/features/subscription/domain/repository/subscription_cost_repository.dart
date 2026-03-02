import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/subscription/data/models/subscription_cost_model.dart';

import '../../../../core/error/failures.dart';

abstract interface class SubscriptionCostRepository {
  Future<Either<Failure, List<SubscriptionCostModel>>> fetchCosts({
    int? periodId,
    int? paymentMethodId,
  });
}
