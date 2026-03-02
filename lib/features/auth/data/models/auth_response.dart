import 'package:qawafi_app/features/auth/data/models/token_response.dart';
import 'package:qawafi_app/core/common/models/user_info.dart';
import 'package:qawafi_app/features/auth/domain/entites/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  AuthResponseModel({
    required super.tokenResponse,
    required super.userInfo,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        tokenResponse: TokenResponseModel.fromJson(json['tokenResponse']),
        userInfo: UserInfoModel.fromJson(json['userInfo']),
      );

  Map<String, dynamic> toJson() => {
        "tokenResponse": tokenResponse,
        "userInfo": userInfo,
      };
}
