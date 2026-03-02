part of 'wallet_transactions_bloc.dart';

@immutable
sealed class WalletTransactionsState {}

final class WalletTransactionsInitial extends WalletTransactionsState {}

final class WalletTransactionsFailure extends WalletTransactionsState {
  final String message;

  WalletTransactionsFailure({required this.message});
}

final class WalletTransactionsLoading extends WalletTransactionsState {}

final class WalletTransactionsLoaded extends WalletTransactionsState {
  final List<WalletTransactionModel> transactions;

  WalletTransactionsLoaded({
    required this.transactions,
  });
}
