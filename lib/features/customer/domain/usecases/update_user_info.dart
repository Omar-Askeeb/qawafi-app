import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/common/models/user_info.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/repository/customer_repository.dart';

class UpdateUserInfo implements UseCase<UserInfoModel, UpdateUserInfoParams> {
  final CustomerRepository repository;

  UpdateUserInfo({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserInfoModel>> call(
      UpdateUserInfoParams params) async {
    return await repository.updateUserInfo(
      userId: params.userId,
      name: params.name,
    );

    // res.fold(
    //   (l) => left(l),
    //   (r) async {
    //     localStorage.storeUser(
    //       jsonEncode(r.toJson()),
    //     );
    //   },
    // );

    // return res;
  }
}

class UpdateUserInfoParams {
  final String userId;
  final String name;

  UpdateUserInfoParams({
    required this.userId,
    required this.name,
  });
}
