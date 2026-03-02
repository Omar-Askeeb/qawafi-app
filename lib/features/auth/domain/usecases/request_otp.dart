import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/auth/domain/repository/auth_repository.dart';

class RequestOtp implements UseCase<void, RequestOtpParams> {
  final AuthRepository authRepository;

  RequestOtp({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(RequestOtpParams params) async {
    // TODO: implement call
    return await authRepository.requestOtp(
      phoneNumber: params.phoneNumber,
    );
  }
}

class RequestOtpParams {
  final String phoneNumber;

  RequestOtpParams({
    required this.phoneNumber,
  });
}
