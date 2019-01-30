import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String shareToken = 'github_access_token';

class Oauth {
  static String clientId = "19fb0f456308a43db1b6";
  static String clientSecret = "1e5b9334dae03f4e4a025c219abd71726fc6c127";
  static String redirectUrl = "https://github.com/Jetsly/gitod";

  static final String authorizeUrl = 'https://github.com/login/oauth/authorize';
  static final String accessTokenUrl =
      "https://github.com/login/oauth/access_token";

  static final String endPoint = 'https://api.github.com/graphql';

  // static final end

  String accessToken;
  String tokenType;

  Oauth.fromJson(Map json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  static Future<String> getRomoteAccessToken(String code) async {
    final http.Response response = await http.post(Oauth.accessTokenUrl, body: {
      "client_id": Oauth.clientId,
      "redirect_uri": Oauth.redirectUrl,
      "client_secret": Oauth.clientSecret,
      "code": code,
    }, headers: {
      'Accept': 'application/json'
    });
    Oauth token = new Oauth.fromJson(json.decode(response.body));
    await Oauth.storeAccessToken(token.accessToken);
    return token.accessToken;
  }

  static Future<String> getLocalAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString(shareToken);
    return accessToken;
  }

  static Future<void> storeAccessToken(String accessToken) async {
    return SharedPreferences.getInstance()
        .then((shared) => shared.setString(shareToken, accessToken));
  }

  static Future<void> clearAccessToken() async {
    return SharedPreferences.getInstance()
        .then((shared) => shared.remove(shareToken));
  }
}
