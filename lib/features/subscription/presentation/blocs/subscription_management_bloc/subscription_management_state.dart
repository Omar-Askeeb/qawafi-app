part of 'subscription_management_bloc.dart';

@immutable
sealed class SubscriptionManagementState {}

final class SubscriptionManagementInitial extends SubscriptionManagementState {}

final class SubscriptionManagementLoading extends SubscriptionManagementState {}

final class SubscriptionManagementFailure extends SubscriptionManagementState {
  final String message;

  SubscriptionManagementFailure({required this.message});
}

final class SubscriptionManagementSucess extends SubscriptionManagementState {
  final List<SubscriptionPeriodModel> bunches;

  SubscriptionManagementSucess({required this.bunches});
}
