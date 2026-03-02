import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/common/models/user_info.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/repository/customer_repository.dart';

class ChargeWallet implements UseCase<UserInfoModel, ChargeWalletParams> {
  final CustomerRepository repository;

  ChargeWallet({required this.repository});
  @override
  Future<Either<Failure, UserInfoModel>> call(ChargeWalletParams params) async {
    return await repository.chargeWallet(
      userId: params.userId,
      cardNo: params.cardNo,
    );
  }
}

class ChargeWalletParams {
  final int cardNo;
  final String userId;
  ChargeWalletParams({
    required this.cardNo,
    required this.userId,
  });
}
