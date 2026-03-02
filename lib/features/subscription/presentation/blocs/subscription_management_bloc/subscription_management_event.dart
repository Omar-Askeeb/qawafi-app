part of 'subscription_management_bloc.dart';

@immutable
sealed class SubscriptionManagementEvent {}

final class SubscriptionManagementFetch extends SubscriptionManagementEvent {}
