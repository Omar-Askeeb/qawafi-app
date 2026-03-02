part of 'verify_subscription_bloc.dart';

@immutable
sealed class VerifySubscriptionEvent {}

final class VerifySubscriptionWalletSubscribeEvent
    extends VerifySubscriptionEvent {
  final int subscriptionCostId;

  VerifySubscriptionWalletSubscribeEvent({required this.subscriptionCostId});
}

final class VerifySubscriptionCancelEvent extends VerifySubscriptionEvent {}
