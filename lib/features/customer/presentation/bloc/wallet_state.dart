part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class WalletFailure extends WalletState {
  final String message;

  WalletFailure({required this.message});
}

final class WalletSuccess extends WalletState {}
