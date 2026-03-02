import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/auth/domain/repository/auth_repository.dart';

class ResetDeviceId implements UseCase<void, StringParam> {
  final AuthRepository authRepository;

  ResetDeviceId({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(StringParam params) {
    return authRepository.resetDeviceId(userId: params.string);
  }
}
