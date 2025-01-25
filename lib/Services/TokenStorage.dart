import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accesstoken = 'accessToken';
  static const String _refereshToken = 'refershToken';
  static Future<void> saveToken(
      String accessToken, String refereshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accesstoken, accessToken);
    await prefs.setString(_refereshToken, refereshToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accesstoken);
  }
  
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refereshToken);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_accesstoken);
    prefs.remove(_refereshToken);
  }
}
