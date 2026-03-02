import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/auth/domain/repository/auth_repository.dart';

class ResetPassword implements UseCase<String, ResetPasswordParams> {
  final AuthRepository authRepository;

  ResetPassword({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(ResetPasswordParams params) async {
    // TODO: implement call
    return await authRepository.resetPassword(
      phoneNumber: params.phoneNumber,
      password: params.password,
      token: params.token,
    );
  }
}

class ResetPasswordParams {
  final String phoneNumber;
  final String password;
  final String token;

  ResetPasswordParams({
    required this.phoneNumber,
    required this.password,
    required this.token,
  });
}
