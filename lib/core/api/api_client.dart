// import 'dart:async';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:qawafi_app/core/api/end_points.dart';
// import 'package:qawafi_app/core/api/status_code.dart';

// import '../error/exceptions.dart';

// class ApiClient {
//   final http.Client client;
//   ApiClient({required this.client});
//   Future<http.Response> get(String url, {Map<String, String>? headers}) async {
//     final response = await responseHandler(
//         () => client.get(Uri.parse(url), headers: headers ?? _headers)).timeout(
//       const Duration(
//         seconds: EndPoints.timeout,
//       ),
//     );

//     return response;
//   }

//   Future<http.Response> post(String url,
//       {Map<String, String>? headers, dynamic body}) async {
//     final response = await responseHandler(() => client.post(Uri.parse(url),
//         headers: headers ?? _headers, body: body)).timeout(
//       const Duration(
//         seconds: EndPoints.timeout,
//       ),
//     );
//     return response;
//   }

//   Map<String, String> get _headers => {
//         'Authorization': 'Bearer ',
//         'Content-Type': 'application/json',
//       };

//   Future<http.Response> responseHandler(
//       Future<http.Response> Function() request) async {
//     try {
//       var response = await request();
//       if (response.statusCode == StatusCode.ok) {
//         return response;
//       }
//       switch (response.statusCode) {
//         case StatusCode.badRequest:
//         case StatusCode.fulfilledRequest:
//           throw BadRequestException();
//         case StatusCode.unauthorized:
//         case StatusCode.forbidden:
//           await _refreshToken();

//         //  throw UnauthorizedException();
//         case StatusCode.notFound:
//         case StatusCode.redirectError:
//           throw NotFoundException();
//         case StatusCode.conflict:
//           throw ConflictException();
//         case StatusCode.invalidMethod:
//           throw BadRequestException();
//         case StatusCode.internalServerError:
//         case StatusCode.serverFileConflict:
//           throw InternalServerErrorException();
//       }
//     } on SocketException {
//       throw FetchDataException();
//     } on HttpException {
//       throw FetchDataException();
//     } on FormatException {
//       throw FetchDataException();
//     } on TimeoutException {
//       throw FetchDataException();
//     } catch (e) {
//       throw NoInternetConnectionException();
//     }
//     throw ServerException();
//   }

//   Future<void> _refreshToken() async {
//     final response = await client.post(
//       Uri.parse('https://yourapi.com/refresh'),
//       body: {'refresh_token': 'token'},
//     );
//     if (response.statusCode == 200) {
//       // final responseBody = json.decode(response.body);
//       // _accessToken = responseBody['access_token'];
//     } else {
//       throw UnauthorizedException();
//     }
//   }
// }
