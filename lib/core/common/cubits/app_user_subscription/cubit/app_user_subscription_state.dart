part of 'app_user_subscription_cubit.dart';

@immutable
sealed class AppUserSubscriptionState {}

final class AppUserSubscriptionInitial extends AppUserSubscriptionState {}

final class AppUserSubscriptionSubscribed extends AppUserSubscriptionState {
  final Subscription subscription;

  AppUserSubscriptionSubscribed({required this.subscription});
}
