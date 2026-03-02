import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/subscription/data/datasources/subscription_cost_remot_date_source.dart';

import 'package:qawafi_app/features/subscription/data/models/subscription_cost_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/subscription_cost_repository.dart';

class SubscriptionCostRepositoryImpl implements SubscriptionCostRepository {
  final CostRemoteDatasource remoteDatasource;

  SubscriptionCostRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<SubscriptionCostModel>>> fetchCosts(
      {int? periodId, int? paymentMethodId}) async {
    try {
      var res = await remoteDatasource.fetchCosts(
        period: periodId,
        paymentMethodId: paymentMethodId,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
