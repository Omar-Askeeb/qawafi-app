part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure({required this.message});
}

final class PaymentSuccess extends PaymentState {
  final List<PaymentMethodModel> methods;

  PaymentSuccess({required this.methods});
}
