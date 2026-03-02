import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/subscription/data/models/subscription_period_model.dart';

import '../../../../core/error/failures.dart';

abstract interface class SubscriptionPeriodRepository {
  Future<Either<Failure, List<SubscriptionPeriodModel>>> fetchPeriods();
}
