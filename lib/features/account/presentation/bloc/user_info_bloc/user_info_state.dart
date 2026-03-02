part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}

final class UserInfoLoading extends UserInfoState {}

final class UserInfoFailure extends UserInfoState {
  final String message;

  UserInfoFailure({
    required this.message,
  });
}

final class UserInfoSuccess extends UserInfoState {}
