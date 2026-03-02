import '../../domain/entites/subscription.dart';

class SubscriptionModel extends Subscription {
  SubscriptionModel({
    required super.subscriptionId,
    required super.userId,
    required super.subscriptionCostId,
    required super.cost,
    required super.durationInDays,
    required super.methodName,
    required super.payment,
    required super.remainingDays,
    required super.subscriptionName,
    required super.subscribedBy,
    required super.startDate,
    required super.endDate,
    required super.canceledAt,
    required super.status,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
          subscriptionId: json["subscriptionId"],
          userId: json["userId"],
          subscriptionCostId: json["subscriptionCostId"],
          cost: json["cost"]?.toDouble(),
          durationInDays: json["durationInDays"],
          methodName: json["methodName"],
          remainingDays: ((json["connexSubscriptionDetails"]?["success"]
                          ?["details"]?["hoursRemind"] ??
                      0) /
                  24)
              .ceil()
              .clamp(1, double.infinity)
              .toInt(),

          // remainingDays: json["remainingDays"],
          payment: json["payment"],
          subscriptionName: json["subscriptionName"],
          subscribedBy: json["subscribedBy"],
          startDate: DateTime.parse(json["startDate"]),
          endDate: DateTime.parse(json["connexSubscriptionDetails"]?["success"]
                  ?["details"]?["expiration_date"] ??
              json["endDate"]),
          //endDate: DateTime.parse(json["endDate"]),
          canceledAt: json["canceledAt"] != null
              ? DateTime.parse(json["canceledAt"])
              : null,
          status: json["connexSubscriptionDetails"]?["success"]?["details"]
              ?["status"]);

  Map<String, dynamic> toJson() => {
        "subscriptionId": subscriptionId,
        "userId": userId,
        "subscriptionCostId": subscriptionCostId,
        "cost": cost,
        "durationInDays": durationInDays,
        "methodName": methodName,
        "payment": payment,
        "remainingDays": remainingDays,
        "subscriptionName": subscriptionName,
        "subscribedBy": subscribedBy,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "canceledAt": canceledAt?.toIso8601String(),
      };

      @override
      String toString() {
        return 'SubscriptionModel(subscriptionId: $subscriptionId, userId: $userId, subscriptionCostId: $subscriptionCostId, cost: $cost, durationInDays: $durationInDays, methodName: $methodName, payment: $payment, remainingDays: $remainingDays, subscriptionName: $subscriptionName, subscribedBy: $subscribedBy, startDate: $startDate, endDate: $endDate, canceledAt: $canceledAt, status: $status)';
      }
}
