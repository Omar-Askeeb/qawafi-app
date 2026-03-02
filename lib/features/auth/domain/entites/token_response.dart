class TokenResponse {
  String accessToken;
  int expiresIn;
  String tokenType;
  String refreshToken;
  String scope;

  TokenResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.refreshToken,
    required this.scope,
  });
}
