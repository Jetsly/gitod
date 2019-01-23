import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:gitod/src/models/token.dart';
import 'package:gitod/src/pages/home_screen.dart';

final String authorize = 'https://github.com/login/oauth/authorize';
final String accessToken = "https://github.com/login/oauth/access_token";

class OauthScreen extends StatefulWidget {
  final String title;
  final String clientId;
  final String clientSecret;
  final String redirectUrl;

  const OauthScreen(
      {@required this.clientId,
      @required this.clientSecret,
      @required this.redirectUrl,
      this.title});

  @override
  _OauthScreenState createState() => _OauthScreenState();
}

class _OauthScreenState extends State<OauthScreen> {
  bool setupUrlChangedListener = false;

  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    final clientId = widget.clientId;
    final clientSecret = widget.clientSecret;
    final redirectUrl = widget.redirectUrl;
    if (!setupUrlChangedListener) {
      flutterWebviewPlugin.onUrlChanged.listen((String changedUrl) async {
        if (changedUrl.startsWith(widget.redirectUrl)) {
          Uri uri = Uri().resolve(changedUrl);
          String code = uri.queryParameters["code"];
          final http.Response response = await http.post(accessToken, body: {
            "client_id": clientId,
            "redirect_uri": redirectUrl,
            "client_secret": clientSecret,
            "code": code,
          }, headers: {
            'Accept': 'application/json'
          });
          Token token = new Token.fromMap(json.decode(response.body));
          await Token.storeAccessToken(token.accessToken);
          Navigator.of(context).pop(token.accessToken);
        }
      });
      setupUrlChangedListener = true;
    }
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Log in with Github"),
      ),
      url:
          "$authorize?scope=repo&client_id=$clientId&redirect_uri=$redirectUrl",
    );
  }
}
