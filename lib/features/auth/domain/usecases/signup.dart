import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/firebase/firebase_api.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/auth/domain/entites/auth_response.dart';
import 'package:qawafi_app/features/customer/domain/usecases/notification_token.dart';

import '../repository/auth_repository.dart';

class SignUp implements UseCase<AuthResponse, SignUpParams> {
  final AuthRepository authRepository;
  final PutNotificationToken putNotificationToken;
  final FirebaseApi firebaseApi;

  SignUp({
    required this.authRepository,
    required this.putNotificationToken,
    required this.firebaseApi,
  });

  @override
  Future<Either<Failure, AuthResponse>> call(SignUpParams params) async {
    // TODO: implement call
    var res = await authRepository.singUpWithPhonePassword(
      name: params.name,
      phoneNumber: params.phoneNumber,
      password: params.password,
      code: params.code,
      deviceId: params.deviceId,
    );

    res.fold(
      (l) => null,
      (r) async {
        putNotificationToken(
          PutNotificationTokenParams(token: await firebaseApi.getToken() ?? ''),
        );
      },
    );

    return res;
  }
}

class SignUpParams {
  final String name;
  final String phoneNumber;
  final String password;
  final String code;
  final String deviceId;

  SignUpParams({
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.code,
    required this.deviceId,
  });
}
