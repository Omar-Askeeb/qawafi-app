part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthOtpSent extends AuthState {
  final String message;

  AuthOtpSent({this.message = 'تم إرسال الكود'});
}

final class AuthOtpState extends AuthState {
  final String phoneNumber;
  final String name;
  final String password;

  AuthOtpState({
    required this.phoneNumber,
    required this.name,
    required this.password,
  });
}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({
    required this.user,
  });
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}

final class AuthResetPasswordTokenState extends AuthState {
  final String token;
  final String phoneNumber;

  AuthResetPasswordTokenState({
    required this.token,
    required this.phoneNumber,
  });
}

final class AuthResuthPasswordSuccess extends AuthState {
  final String message;

  AuthResuthPasswordSuccess({
    required this.message,
  });
}

final class AuthSignoutState extends AuthState {}
