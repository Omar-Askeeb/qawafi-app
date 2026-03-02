class Subscription {
  int subscriptionId;
  String userId;
  int subscriptionCostId;
  double cost;
  int durationInDays;
  String methodName;
  String payment;
  int remainingDays;
  String subscriptionName;
  String subscribedBy;
  DateTime startDate;
  DateTime endDate;
  DateTime? canceledAt;
  String status;

  Subscription({
    required this.subscriptionId,
    required this.userId,
    required this.subscriptionCostId,
    required this.cost,
    required this.durationInDays,
    required this.methodName,
    required this.payment,
    required this.remainingDays,
    required this.subscriptionName,
    required this.subscribedBy,
    required this.startDate,
    required this.endDate,
    required this.canceledAt,
    required this.status,
  });
}
