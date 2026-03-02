part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String phoneNumber;
  final String password;

  AuthLogin({required this.phoneNumber, required this.password});
}

final class AuthRequestOtp extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String name;
  final bool isResend;

  AuthRequestOtp({
    required this.phoneNumber,
    required this.password,
    required this.name,
    this.isResend = false,
  });
}

final class AuthSignUp extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String name;
  final String code;

  AuthSignUp({
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.code,
  });
}

final class AuthGetResetPasswordToken extends AuthEvent {
  final String phoneNumber;
  final String otp;

  AuthGetResetPasswordToken({
    required this.phoneNumber,
    required this.otp,
  });
}

final class ResetPasswordEvent extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String token;

  ResetPasswordEvent({
    required this.phoneNumber,
    required this.password,
    required this.token,
  });
}

final class AuthSignOut extends AuthEvent {}
