import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/repository/customer_repository.dart';

class ChangePassword implements UseCase<String, ChangePasswordParams> {
  final CustomerRepository repository;

  ChangePassword({required this.repository});
  @override
  Future<Either<Failure, String>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
        password: params.password, newPassword: params.newPassword);
  }
}

class ChangePasswordParams {
  final String password;
  final String newPassword;

  ChangePasswordParams({
    required this.password,
    required this.newPassword,
  });
}
