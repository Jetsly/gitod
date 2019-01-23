import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final String token = 'github_access_token';

class Token {
  String accessToken;
  String tokenType;

  Token.fromMap(Map json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  static Future<String> getLocalAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString(token);
    return accessToken;
  }

  static Future<void> storeAccessToken(String accessToken) async {
    return SharedPreferences.getInstance()
        .then((shared) => shared.setString(token, accessToken));
  }
}
