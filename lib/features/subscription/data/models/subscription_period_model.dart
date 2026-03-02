import '../../domain/entites/subscription_period.dart';
import 'subscription_cost_model.dart';

class SubscriptionPeriodModel extends SubscriptionPeriod {
  List<SubscriptionCostModel>? subscriptionCosts;

  SubscriptionPeriodModel({
    required super.subscriptionPeriodId,
    required super.subscriptionName,
    required super.description,
    required super.durationInDays,
    required super.isDisabled,
    this.subscriptionCosts,
  });

  factory SubscriptionPeriodModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPeriodModel(
        subscriptionPeriodId: json["subscriptionPeriodId"],
        subscriptionName: json["subscriptionName"],
        description: json["description"],
        durationInDays: json["durationInDays"],
        isDisabled: json["isDisabled"],
      );

  Map<String, dynamic> toJson() => {
        "subscriptionPeriodId": subscriptionPeriodId,
        "subscriptionName": subscriptionName,
        "description": description,
        "durationInDays": durationInDays,
        "isDisabled": isDisabled,
        "subscriptionCosts":
            subscriptionCosts != null ? subscriptionCosts!.length : 0,
      };

  SubscriptionPeriodModel copyWith({
    List<SubscriptionCostModel>? subscriptionCosts,
  }) {
    return SubscriptionPeriodModel(
      subscriptionPeriodId: subscriptionPeriodId,
      subscriptionName: subscriptionName,
      description: description,
      durationInDays: durationInDays,
      isDisabled: isDisabled,
      subscriptionCosts: subscriptionCosts ?? this.subscriptionCosts,
    );
  }

  @override
  String toString() {
    return 'SubscriptionPeriodModel(subscriptionPeriodId: $subscriptionPeriodId, subscriptionName: $subscriptionName, description: $description, durationInDays: $durationInDays, isDisabled: $isDisabled, subscriptionCosts: $subscriptionCosts)';
  }
}
