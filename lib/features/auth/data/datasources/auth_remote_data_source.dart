import 'dart:convert';
import 'dart:developer';

import 'package:qawafi_app/core/api/api_client2.dart';
import 'package:qawafi_app/core/api/end_points.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/features/auth/data/models/auth_response.dart';

import '../../../../core/localStorage/loacal_storage.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthResponseModel> singUpWithPhonePassword({
    required name,
    required phoneNumber,
    required password,
    required code,
    required deviceId,
  });

  Future<AuthResponseModel> refreshToken({required String refreshToken});

  Future<AuthResponseModel> loginWithPhonePassword({
    required phoneNumber,
    required password,
    required deviceId,
  });

  Future<void> requestOtp({
    required phoneNumber,
  });

  Future<void> resetDeviceId({
    required String userId,
  });

  Future<String> getResetPasswordToken({
    required String phoneNumber,
    required String otp,
  });

  Future<String> resetPassword({
    required String phoneNumber,
    required String password,
    required String token,
  });
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiClient httpClient;
  final LocalStorage localStorage;

  AuthRemoteDataSourceImp({
    required this.httpClient,
    required this.localStorage,
  });

  @override
  Future<AuthResponseModel> loginWithPhonePassword(
      {required phoneNumber, required password, required deviceId}) async {
    // TODO: implement loginWithPhonePassword
    try {
      var response = await httpClient.post(
        EndPoints.login,
        headers: {'Content-Type': 'application/json-patch+json'},
        body: jsonEncode({
          'client_id': 'mobile.app',
          'client_secret': 'f8f53730-f12b-43c7-94d0-4e952880126e',
          'scope': 'customer IdentityServerApi offline_access',
          'username': phoneNumber,
          'password': password,
          "device_id": deviceId,
        }),
      );
      log(
        jsonEncode(
          {
            'client_id': 'mobile.app',
            'client_secret': 'f8f53730-f12b-43c7-94d0-4e952880126e',
            'scope': 'customer IdentityServerApi offline_access',
            'username': phoneNumber,
            'password': password,
            "device_id": deviceId,
          },
        ),
      );

      //cniOjGDxSbuUlnrlS3LTRr:APA91bELSS3s4excqj71A3Bbfc3-sxm6zhKWAkZ_1ta0zPPVq2rWBrHJXEyYjUMQhfTaaIZdRL2hBstyyqdqFJ3vaSxhpZwWRMmbs54XB5p_0ljkcLy2xVIhcYB9yAFwc1gFxHkh7qLd
      AuthResponseModel auth = AuthResponseModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);

      await localStorage.storeAccessToken(auth.tokenResponse.accessToken);
      await localStorage.storeRefreshToken(auth.tokenResponse.refreshToken);
      await localStorage.storeUserData(
        {
          'name': auth.userInfo.userName,
          'phoneNumber': auth.userInfo.phoneNumber,
        }.toString(),
      );

      return auth;
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<AuthResponseModel> singUpWithPhonePassword({
    required name,
    required phoneNumber,
    required password,
    required code,
    required deviceId,
  }) async {
    // TODO: implement singUpWithPhonePassword
    try {
      var response = await httpClient.post(
        EndPoints.signUp,
        headers: {'Content-Type': 'application/json-patch+json'},
        body: jsonEncode({
          "client_id": "mobile.app",
          "client_secret": "f8f53730-f12b-43c7-94d0-4e952880126e",
          "scope": "customer IdentityServerApi offline_access",
          "phoneNumber": phoneNumber,
          "fullName": name,
          "password": password,
          "code": code,
          "device_id": deviceId,
        }),
      );
      AuthResponseModel auth = AuthResponseModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);

      await localStorage.storeAccessToken(auth.tokenResponse.accessToken);

      return auth;
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<void> requestOtp({required phoneNumber}) async {
    try {
      log(
        jsonEncode(
          {"phoneNumber": phoneNumber},
        ),
      );
      await httpClient.post(
        EndPoints.requestOtp,
        body: jsonEncode(
          {"phoneNumber": phoneNumber},
        ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<String> getResetPasswordToken({
    required String phoneNumber,
    required String otp,
  }) async {
    // TODO: implement getResetPasswordToken
    try {
      log(
        jsonEncode(
          {
            "phoneNumber": phoneNumber,
            "otpCode": otp,
          },
        ),
      );
      var response = await httpClient.post(
        EndPoints.getResetPasswordToken,
        body: jsonEncode(
          {
            "phoneNumber": phoneNumber,
            "otpCode": otp,
          },
        ),
      );
      log(response.body);
      return json.decode(
        utf8.decode(response.bodyBytes),
      )['data']['token'];
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<String> resetPassword({
    required String phoneNumber,
    required String password,
    required String token,
  }) async {
    // TODO: implement resetPassword
    try {
      log(
        jsonEncode({
          "phoneNumber": phoneNumber,
          "password": password,
          "token": token,
        }),
      );

      var response = await httpClient.post(
        EndPoints.resetPassword,
        body: jsonEncode({
          "phoneNumber": phoneNumber,
          "password": password,
          "token": token,
        }),
      );
      log(
        response.body,
      );
      log(
        json.decode(
          utf8.decode(response.bodyBytes),
        )["messages"][0],
      );
      return json.decode(
        utf8.decode(response.bodyBytes),
      )['messages'][0];
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<AuthResponseModel> refreshToken({required String refreshToken}) async {
    // TODO: implement loginWithPhonePassword
    try {
      var response = await httpClient.post(
        EndPoints.customerRefreshToken,
        headers: {'Content-Type': 'application/json-patch+json'},
        body: jsonEncode({
          'client_id': 'mobile.app',
          'client_secret': 'f8f53730-f12b-43c7-94d0-4e952880126e',
          "refresh_token": refreshToken,
        }),
      );

      //cniOjGDxSbuUlnrlS3LTRr:APA91bELSS3s4excqj71A3Bbfc3-sxm6zhKWAkZ_1ta0zPPVq2rWBrHJXEyYjUMQhfTaaIZdRL2hBstyyqdqFJ3vaSxhpZwWRMmbs54XB5p_0ljkcLy2xVIhcYB9yAFwc1gFxHkh7qLd
      AuthResponseModel auth = AuthResponseModel.fromJson(json.decode(
        utf8.decode(response.bodyBytes),
      )['data']);

      await localStorage.storeAccessToken(auth.tokenResponse.accessToken);
      await localStorage.storeUserData(
        {
          'name': auth.userInfo.userName,
          'phoneNumber': auth.userInfo.phoneNumber,
          'balance': auth.userInfo.balance,
          '': auth.userInfo.userId,
        }.toString(),
      );

      return auth;
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<void> resetDeviceId({required String userId}) async {
    try {
      await httpClient.put(
        EndPoints.resetDeviceId,
        body: jsonEncode(
          {"userId": userId},
        ),
      );
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
