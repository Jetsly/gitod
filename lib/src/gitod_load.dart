import 'package:flutter/material.dart';
import 'package:gitod/src/models/oauth.dart';
import 'package:gitod/src/models/token.dart';
import 'package:gitod/src/pages/oauth_screen.dart';
import 'package:gitod/src/pages/home_screen.dart';

class GitodLoad extends StatefulWidget {
  GitodLoad({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _GitodLoadState();
}

class _GitodLoadState extends State<GitodLoad> {
  String accssToken = '';

  @override
  initState() {
    super.initState();
    loadAccessToken();
  }

  loadAccessToken() async {
    String token = await Token.getLocalAccessToken();
    if (token == null) {
      token = await Navigator.of(context).push(MaterialPageRoute<String>(
          builder: (context) => OauthScreen(
              title: widget.title,
              clientId: Oauth.clientId,
              clientSecret: Oauth.clientSecret,
              redirectUrl: Oauth.redirectUrl)));
    }
    setState(() {
      accssToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (accssToken == '') {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Text(
          'Loading',
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return HomeScreen(accessToken: accssToken, title: widget.title);
    }
  }
}
