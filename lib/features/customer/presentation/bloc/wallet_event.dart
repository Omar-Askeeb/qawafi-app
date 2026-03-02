part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

final class WalletChargeEvent extends WalletEvent {
  final int cardNo;

  WalletChargeEvent({required this.cardNo});
}
