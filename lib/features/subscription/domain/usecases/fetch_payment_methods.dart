import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/subscription/data/models/payment_method_model.dart';
import 'package:qawafi_app/features/subscription/domain/repository/payment_methods_repository.dart';

import '../../../../core/usecase/usecase.dart';

class FetchPaymentMethods
    implements UseCase<List<PaymentMethodModel>, NoParams> {
  final PaymentMethodRepository repository;

  FetchPaymentMethods({required this.repository});
  @override
  Future<Either<Failure, List<PaymentMethodModel>>> call(
      NoParams params) async {
    return await repository.fetchPaymentMethods();
  }
}
