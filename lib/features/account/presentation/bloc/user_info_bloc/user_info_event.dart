part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoEvent {}

final class UserInfoUpdateEvent extends UserInfoEvent {
  final String name;
  final String userId;

  UserInfoUpdateEvent({
    required this.name,
    required this.userId,
  });
}
