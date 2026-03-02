import 'dart:developer';

import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/firebase/firebase_api.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/auth/domain/entites/auth_response.dart';
import 'package:qawafi_app/features/auth/domain/repository/auth_repository.dart';
import 'package:qawafi_app/features/customer/domain/usecases/notification_token.dart';

class Login implements UseCase<AuthResponse, LoginParam> {
  final AuthRepository authRepository;
  final PutNotificationToken putNotificationToken;
  final FirebaseApi firebaseApi;

  Login({
    required this.authRepository,
    required this.putNotificationToken,
    required this.firebaseApi,
  });

  @override
  Future<Either<Failure, AuthResponse>> call(LoginParam params) async {
    // TODO: implement call
    var res = await authRepository.loginWithPhonePassword(
      phoneNumber: params.phoneNumber,
      password: params.password,
      deviceId: params.deviceId,
    );
    res.fold(
      (l) => null,
      (r) async {
        log('message : ${await firebaseApi.getToken()}');
        await putNotificationToken(
          PutNotificationTokenParams(token: await firebaseApi.getToken() ?? ''),
        );
      },
    );

    return res;
  }
}

class LoginParam {
  final String phoneNumber;
  final String password;
  final String deviceId;

  LoginParam({
    required this.phoneNumber,
    required this.password,
    required this.deviceId,
  });
}
