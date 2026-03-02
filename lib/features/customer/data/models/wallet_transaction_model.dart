import 'package:qawafi_app/features/customer/domain/entites/wallet_transacion.dart';

class WalletTransactionModel extends WalletTransaction {
  WalletTransactionModel({
    required super.userId,
    required super.description,
    required super.amount,
    required super.date,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) =>
      WalletTransactionModel(
        userId: json["userId"],
        description: json["description"],
        amount: json["amount"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "description": description,
        "amount": amount,
        "date": date,
      };
}
