import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/common/models/user_info.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/auth/domain/repository/auth_repository.dart';

class RefreshToken implements UseCase<UserInfoModel, RereshTokenParams> {
  final AuthRepository authRepository;

  RefreshToken({required this.authRepository});
  @override
  Future<Either<Failure, UserInfoModel>> call(RereshTokenParams params) async {
    return (await authRepository.refreshToken(refreshToken: params.token));
  }
}

class RereshTokenParams {
  final String token;

  RereshTokenParams({required this.token});
}
