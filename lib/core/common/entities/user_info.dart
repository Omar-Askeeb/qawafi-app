class UserInfo {
  String userId;
  String userName;
  String phoneNumber;
  String fullName;
  bool isDisabled;
  dynamic disableAt;
  String note;
  double balance;
  DateTime created;
  dynamic lastModified;
  String customerType;

  UserInfo({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.fullName,
    required this.isDisabled,
    required this.disableAt,
    required this.note,
    required this.created,
    required this.lastModified,
    required this.customerType,
    required this.balance,
  });
}
