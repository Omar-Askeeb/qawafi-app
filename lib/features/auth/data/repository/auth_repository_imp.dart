import 'dart:developer';
import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/common/models/user_info.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:qawafi_app/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/network/connection_checker.dart';
import '../models/auth_response.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImp(
      {required this.remoteDataSource, required this.connectionChecker});

  @override
  Future<Either<Failure, AuthResponseModel>> loginWithPhonePassword({
    required String phoneNumber,
    required String password,
    required String deviceId,
  }) async {
    // TODO: implement loginWithPhonePassword
    log('Repository');
    try {
      var authResponse = await remoteDataSource.loginWithPhonePassword(
        phoneNumber: phoneNumber,
        password: password,
        deviceId: deviceId,
      );

      return right(authResponse);
    } on ServerException catch (e) {
      log(e.toString());
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> singUpWithPhonePassword({
    required String name,
    required String phoneNumber,
    required String password,
    required String code,
    required String deviceId,
  }) async {
    // TODO: implement singUpWithPhonePassword
    try {
      var authResponse = await remoteDataSource.singUpWithPhonePassword(
        phoneNumber: phoneNumber,
        password: password,
        code: code,
        name: name,
        deviceId: deviceId,
      );

      return right(authResponse);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> requestOtp({required phoneNumber}) async {
    // TODO: implement requestOtp
    try {
      await remoteDataSource.requestOtp(
        phoneNumber: phoneNumber,
      );

      return right(null);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getResetPasswordToken(
      {required String phoneNumber, required String otp}) async {
    // TODO: implement getResetPasswordToken
    try {
      if (await (connectionChecker.isConnected)) {
        String token = await remoteDataSource.getResetPasswordToken(
          phoneNumber: phoneNumber,
          otp: otp,
        );

        return right(token);
      } else {
        throw NoInternetConnectionException();
      }
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String phoneNumber,
    required String password,
    required String token,
  }) async {
    // TODO: implement resetPassword
    try {
      if (await (connectionChecker.isConnected)) {
        var res = await remoteDataSource.resetPassword(
          phoneNumber: phoneNumber,
          password: password,
          token: token,
        );

        return right(res);
      } else {
        throw NoInternetConnectionException();
      }
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserInfoModel>> refreshToken(
      {required String refreshToken}) async {
    // TODO: implement loginWithPhonePassword
    log('Repository');
    try {
      var authResponse = await remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );

      return right(authResponse.userInfo as UserInfoModel);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> resetDeviceId({required String userId}) async {
    // TODO: implement loginWithPhonePassword
    log('Repository');
    try {
      await remoteDataSource.resetDeviceId(
        userId: userId,
      );

      return right('');
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
