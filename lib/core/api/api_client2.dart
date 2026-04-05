import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/utils/refresh_token_expired.dart';

import '../../features/auth/data/models/auth_response.dart';
import '../common/entities/user.dart';
import '../error/exceptions.dart';
import '../localStorage/loacal_storage.dart';
import 'status_code.dart';

class ApiClient {
  final http.Client httpClient;
  final LocalStorage localStorage;
  final AppUserCubit appUserCubit;

  ApiClient({
    required this.httpClient,
    required this.localStorage,
    required this.appUserCubit,
  });

  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    log(url);
    final response = await _sendRequest(
      () async => httpClient.get(
        Uri.parse(url),
        headers: headers ?? (await _headers),
      ),
    );
    return response;
  }

  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    log(url);
    final response = await _sendRequest(() async => httpClient.post(
        Uri.parse(url),
        headers: headers ?? (await _headers),
        body: body));
    log('message');
    return response;
  }

  Future<http.Response> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    log(url);
    final response = await _sendRequest(() async => httpClient
        .put(Uri.parse(url), headers: headers ?? (await _headers), body: body));
    log('message');
    return response;
  }

  Future<http.Response> _sendRequest(
      Future<http.Response> Function() request) async {
    try {
      http.Response response = await request().timeout(
        const Duration(seconds: 10),
      );
      log(response.request!.headers.toString());
      log(response.request!.url.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 401) {
        // Handle token expiration
        if (appUserCubit.state is AppUserLoggedIn) {
          await _refreshToken();
          response =
              await request(); // Retry the original request with the new token
        }
      }
      _handleResponse(response);
      return response;
    } on SocketException {
      throw NoInternetConnectionException();
    } on HttpException {
      throw FetchDataException();
    } on FormatException {
      throw FetchDataException();
    } on TimeoutException {
      throw FetchDataException();
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _refreshToken() async {
    log("REFRESH TOKEN : " + (await localStorage.refreshToken));
    final response = await httpClient.post(
      Uri.parse(EndPoints.customerRefreshToken),
      headers: await _headers,
      body: jsonEncode({
        'client_id': 'mobile.app',
        'client_secret': 'f8f53730-f12b-43c7-94d0-4e952880126e',
        "refresh_token": await localStorage.refreshToken,
      }),
      // body: {'refresh_token': _refreshTokenVar},
    );
    if (response.statusCode == 200) {
      AuthResponseModel auth = AuthResponseModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);

      await localStorage.storeAccessToken(auth.tokenResponse.accessToken);
      User user = User(
          fullName: auth.userInfo.fullName,
          note: auth.userInfo.note,
          balance: auth.userInfo.balance,
          customerType: auth.userInfo.customerType,
          id: auth.userInfo.userId,
          phoneNumber: auth.userInfo.phoneNumber,
          name: auth.userInfo.fullName);
      localStorage.storeUser(jsonEncode(user.toJson()));

      await localStorage.storeUserData(
        {
          'name': auth.userInfo.userName,
          'phoneNumber': auth.userInfo.phoneNumber,
          'balance': auth.userInfo.balance,
          '': auth.userInfo.userId,
        }.toString(),
      );
      appUserCubit.updateUser(user);
      // _accessToken = responseBody['access_token'];
    }
    if (response.statusCode == 401) {
      appUserCubit.updateUser(null);
      handleTokenExpiration(localStorage);
    } else {
      throw UnauthorizedException();
    }
  }

  Future<Map<String, String>> get _headers async => {
        'Content-Type': 'application/json',
        'Authorization': (await localStorage.accessToken),
      };

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode == StatusCode.ok) {
      return response;
    }

    switch (response.statusCode) {
      case StatusCode.badRequest:
      case StatusCode.fulfilledRequest:
        throw BadRequestException();
      case StatusCode.unauthorized:
      case StatusCode.forbidden:

      //  throw UnauthorizedException();
      case StatusCode.notFound:
      case StatusCode.redirectError:
        throw NotFoundException();
      case StatusCode.conflict:
        throw ConflictException(json.decode(
                  utf8.decode(response.bodyBytes),
                )['messages'] !=
                null
            ? json.decode(
                utf8.decode(response.bodyBytes),
              )['messages'][0]
            : "");
      case StatusCode.tooManyRequests:
        throw TooManyRequests();
      case StatusCode.invalidMethod:
        throw BadRequestException();
      case StatusCode.internalServerError:
      case StatusCode.serverFileConflict:
        throw InternalServerErrorException();
    }
    throw ServerException();
  }
}
