import '../../../../core/common/models/user_info.dart';
import '../../domain/entites/auth_response.dart';
import '/../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthResponse>> singUpWithPhonePassword({
    required String name,
    required String phoneNumber,
    required String password,
    required String code,
    required String deviceId,
  });

  Future<Either<Failure, void>> resetDeviceId({
    required String userId,
  });

  Future<Either<Failure, AuthResponse>> loginWithPhonePassword({
    required String phoneNumber,
    required String password,
    required String deviceId,
  });

  Future<Either<Failure, void>> requestOtp({
    required phoneNumber,
  });

  Future<Either<Failure, String>> getResetPasswordToken(
      {required String phoneNumber, required String otp});

  Future<Either<Failure, String>> resetPassword({
    required String phoneNumber,
    required String password,
    required String token,
  });

  Future<Either<Failure, UserInfoModel>> refreshToken(
      {required String refreshToken});
}
