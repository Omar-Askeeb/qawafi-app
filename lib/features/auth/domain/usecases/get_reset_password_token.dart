import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';

import '../repository/auth_repository.dart';

class GetResetPasswordToken implements UseCase<String, GetResetPassTokenParam> {
  final AuthRepository authRepository;

  GetResetPasswordToken({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(params) async {
    return await authRepository.getResetPasswordToken(
      phoneNumber: params.phoneNumber,
      otp: params.otp,
    );
  }
}

class GetResetPassTokenParam {
  final String phoneNumber;
  final String otp;

  GetResetPassTokenParam({
    required this.phoneNumber,
    required this.otp,
  });
}
