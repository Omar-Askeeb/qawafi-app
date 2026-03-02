import '../../domain/entites/token_response.dart';

class TokenResponseModel extends TokenResponse {
  TokenResponseModel(
      {required super.accessToken,
      required super.expiresIn,
      required super.tokenType,
      required super.refreshToken,
      required super.scope});

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      TokenResponseModel(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        tokenType: json["token_type"],
        refreshToken: json["refresh_token"] ?? '',
        scope: json["scope"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "token_type": tokenType,
        "refresh_token": refreshToken,
        "scope": scope,
      };
}
