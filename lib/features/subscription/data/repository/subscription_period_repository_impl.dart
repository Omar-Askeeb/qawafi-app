import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/subscription/data/datasources/subscription_period_remot_date_source.dart';

import 'package:qawafi_app/features/subscription/data/models/subscription_period_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/subscription_period_repository.dart';

class SubscriptionPeriodRepositoryImpl implements SubscriptionPeriodRepository {
  final PeriodRemoteDatasource remoteDatasource;

  SubscriptionPeriodRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<SubscriptionPeriodModel>>> fetchPeriods() async {
    try {
      var res = await remoteDatasource.fetchPeriods();
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
