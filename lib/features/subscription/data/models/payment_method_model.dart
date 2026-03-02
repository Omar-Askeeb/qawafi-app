import '../../domain/entites/payment_method.dart';

class PaymentMethodModel extends PaymentMethod {
  PaymentMethodModel({
    required super.paymentMethodId,
    required super.methodName,
    required super.isDisabled,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        paymentMethodId: json["paymentMethodId"],
        methodName: json["methodName"],
        isDisabled: json["isDisabled"],
      );

  Map<String, dynamic> toJson() => {
        "paymentMethodId": paymentMethodId,
        "methodName": methodName,
        "isDisabled": isDisabled,
      };
}
