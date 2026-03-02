part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent {}

final class ChangePasswordDoEvent extends ChangePasswordEvent {
  final String password;
  final String newPassword;

  ChangePasswordDoEvent({
    required this.password,
    required this.newPassword,
  });
}
