class PaymentMethod {
  int paymentMethodId;
  String methodName;
  bool isDisabled;

  PaymentMethod({
    required this.paymentMethodId,
    required this.methodName,
    required this.isDisabled,
  });
}
