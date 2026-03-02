part of 'verify_subscription_bloc.dart';

@immutable
sealed class VerifySubscriptionState {}

final class VerifySubscriptionInitial extends VerifySubscriptionState {}

final class VerifySubscriptionLoading extends VerifySubscriptionState {}

final class VerifySubscriptionFailure extends VerifySubscriptionState {
  final String message;

  VerifySubscriptionFailure({required this.message});
}

final class VerifySubscriptionSuccess extends VerifySubscriptionState {}
