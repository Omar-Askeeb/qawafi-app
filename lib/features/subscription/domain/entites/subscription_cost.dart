class SubscriptionCost {
  int subscriptionCostId;
  int subscriptionPeriodId;
  int paymentMethodId;
  String subscriptionName;
  String cost;
  String description;
  int durationInDays;
  String methodName;
  String payment;
  String systemCarrier;

  SubscriptionCost({
    required this.subscriptionCostId,
    required this.subscriptionPeriodId,
    required this.paymentMethodId,
    required this.subscriptionName,
    required this.cost,
    required this.description,
    required this.durationInDays,
    required this.methodName,
    required this.payment,
    required this.systemCarrier,
  });
}
