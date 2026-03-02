import 'package:qawafi_app/features/support/domain/entities/support.dart';

class ContactModel extends Contact {
  ContactModel({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String title,
    required String content,
  }) : super(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          title: title,
          content: content,
        );

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'title': title,
      'content': content,
    };
  }
}
