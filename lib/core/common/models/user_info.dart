import 'package:qawafi_app/core/common/entities/user_info.dart';

class UserInfoModel extends UserInfo {
  UserInfoModel({
    required super.userId,
    required super.userName,
    required super.phoneNumber,
    required super.fullName,
    required super.isDisabled,
    required super.disableAt,
    required super.note,
    required super.created,
    required super.lastModified,
    required super.customerType,
    required super.balance,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        userId: json["userId"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        isDisabled: json["isDisabled"],
        disableAt: json["disableAt"],
        note: json["note"],
        created: DateTime.parse(json["created"]),
        lastModified: json["lastModified"],
        customerType: json["customerType"],
        balance: double.tryParse(json["balance"]) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "isDisabled": isDisabled,
        "disableAt": disableAt,
        "note": note,
        "created": created.toIso8601String(),
        "lastModified": lastModified,
        "customerType": customerType,
        "balance": balance.toString(),
      };
}
