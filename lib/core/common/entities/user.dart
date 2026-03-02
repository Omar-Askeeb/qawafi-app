class User {
  final String id;
  final String phoneNumber;
  final String name;
  final String fullName;
  final String note;
  final double balance;
  final String customerType;

  User({
    required this.fullName,
    required this.note,
    required this.balance,
    required this.customerType,
    required this.id,
    required this.phoneNumber,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'phoneNumber': phoneNumber,
        'name': name,
        'fullName': fullName,
        'note': note,
        'balance': balance,
        'customerType': customerType,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        fullName: json['fullName'],
        note: json['note'],
        balance: json['balance'],
        customerType: json['customerType'],
      );
}
