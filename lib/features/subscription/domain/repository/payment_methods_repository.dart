import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/features/subscription/data/models/payment_method_model.dart';

import '../../../../core/error/failures.dart';

abstract interface class PaymentMethodRepository {
  Future<Either<Failure, List<PaymentMethodModel>>> fetchPaymentMethods();
}
