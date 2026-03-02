import 'dart:convert';
import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';

abstract class ContactRemoteDataSource {
  Future<String> SendContact(String fullName, String phoneNumber, String email,
      String title, String description);
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final ApiClient httpClient;

  ContactRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<String> SendContact(String fullName, String phoneNumber, String email,
      String title, String description) async {
    // TODO: implement PostContact
    final response = await httpClient.post('${EndPoints.support}',
        body: jsonEncode({
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "email": "Test@Test.com",
          "title": title,
          "content": description
        }));

    return "تم إرسال الرسالة";
  }
}
