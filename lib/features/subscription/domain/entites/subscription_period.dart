class SubscriptionPeriod {
  int subscriptionPeriodId;
  String subscriptionName;
  String description;
  int durationInDays;
  bool isDisabled;

  SubscriptionPeriod({
    required this.subscriptionPeriodId,
    required this.subscriptionName,
    required this.description,
    required this.durationInDays,
    required this.isDisabled,
  });
}
