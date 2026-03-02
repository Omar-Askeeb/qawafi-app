// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'token_response.dart';
import '../../../../core/common/entities/user_info.dart';

class AuthResponse {
  TokenResponse tokenResponse;
  UserInfo userInfo;

  AuthResponse({
    required this.tokenResponse,
    required this.userInfo,
  });
}
