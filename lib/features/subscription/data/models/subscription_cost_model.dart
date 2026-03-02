import '../../domain/entites/subscription_cost.dart';

class SubscriptionCostModel extends SubscriptionCost {
  SubscriptionCostModel({
    required super.subscriptionCostId,
    required super.subscriptionPeriodId,
    required super.paymentMethodId,
    required super.subscriptionName,
    required super.cost,
    required super.description,
    required super.durationInDays,
    required super.methodName,
    required super.payment,
    required super.systemCarrier,
  });

  factory SubscriptionCostModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionCostModel(
        subscriptionCostId: json["subscriptionCostId"],
        subscriptionPeriodId: json["subscriptionPeriodId"],
        paymentMethodId: json["paymentMethodId"],
        subscriptionName: json["subscriptionName"],
        cost: json["cost"],
        description: json["description"],
        durationInDays: json["durationInDays"],
        methodName: json["methodName"],
        payment: json["payment"],
        systemCarrier: json["systemCarrier"],
      );

  Map<String, dynamic> toJson() => {
        "subscriptionCostId": subscriptionCostId,
        "subscriptionPeriodId": subscriptionPeriodId,
        "paymentMethodId": paymentMethodId,
        "subscriptionName": subscriptionName,
        "cost": cost,
        "description": description,
        "durationInDays": durationInDays,
        "methodName": methodName,
        "payment": payment,
      };

      @override
      String toString() {
        return 'SubscriptionCostModel(subscriptionCostId: $subscriptionCostId, subscriptionPeriodId: $subscriptionPeriodId, paymentMethodId: $paymentMethodId, subscriptionName: $subscriptionName, cost: $cost, description: $description, durationInDays: $durationInDays, methodName: $methodName, payment: $payment, systemCarrier: $systemCarrier)';
      }
}
