class LoginResponseM {
  final String accessToken;
  final String refereshToken;
  LoginResponseM({required this.accessToken, required this.refereshToken});

  factory LoginResponseM.fromJson(Map<String, dynamic> json) {
    return LoginResponseM(
        accessToken: json['token'], refereshToken: json['refreshToken']);
  }
}
