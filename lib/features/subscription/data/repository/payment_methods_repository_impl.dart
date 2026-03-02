import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/subscription/data/datasources/payment_method_remote_datasource.dart';
import 'package:qawafi_app/features/subscription/data/models/payment_method_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repository/payment_methods_repository.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final PaymentMethodRemoteDatasource remoteDatasource;

  PaymentMethodRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<PaymentMethodModel>>>
      fetchPaymentMethods() async {
    try {
      var res = await remoteDatasource.fetchPaymentMethods();
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
