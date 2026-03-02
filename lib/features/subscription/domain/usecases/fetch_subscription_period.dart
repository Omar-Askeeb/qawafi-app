import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/subscription/domain/repository/subscription_period_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../../data/models/subscription_period_model.dart';

class FetchSubscriptionPeriod
    implements UseCase<List<SubscriptionPeriodModel>, NoParams> {
  final SubscriptionPeriodRepository repository;

  FetchSubscriptionPeriod({required this.repository});
  @override
  Future<Either<Failure, List<SubscriptionPeriodModel>>> call(
      NoParams params) async {
    return await repository.fetchPeriods();
  }
}
