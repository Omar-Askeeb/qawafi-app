import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/repository/customer_repository.dart';

import '../../data/models/wallet_transaction_model.dart';

class FetchWalletTransactions
    implements UseCase<List<WalletTransactionModel>, StringParam> {
  final CustomerRepository repository;

  FetchWalletTransactions({required this.repository});
  @override
  Future<Either<Failure, List<WalletTransactionModel>>> call(
      StringParam params) async {
    return await repository.fetchTransactions(userId: params.string);
  }
}
