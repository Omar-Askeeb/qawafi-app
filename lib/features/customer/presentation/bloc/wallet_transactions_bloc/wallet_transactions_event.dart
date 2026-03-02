part of 'wallet_transactions_bloc.dart';

@immutable
sealed class WalletTransactionsEvent {}

final class WalletTransactionsFetchEvent extends WalletTransactionsEvent {}
