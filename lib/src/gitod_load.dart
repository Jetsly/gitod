import 'package:flutter/material.dart';
import 'package:gitod/src/models/oauth.dart';
import 'package:gitod/src/screen/oauth_screen.dart';
import 'package:gitod/src/screen/home_screen.dart';
import 'package:gitod/src/layouts/home_layout.dart';

class GitodLoad extends StatefulWidget {
  GitodLoad({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _GitodLoadState();
}

class _GitodLoadState extends State<GitodLoad> {
  String accssToken = '';
  bool initialToken = true;

  _loadAccessToken() async {
    initialToken = false;
    String token = await Oauth.getLocalAccessToken();
    if (token == null) {
      String code = await Navigator.of(context).push(MaterialPageRoute<String>(
          builder: (context) => OauthScreen(
              clientId: Oauth.clientId,
              redirectUrl: Oauth.redirectUrl,
              authorizeUrl: Oauth.authorizeUrl)));
      token = await Oauth.getRomoteAccessToken(code);
    }
    setState(() {
      accssToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (accssToken == '') {
      if (initialToken) {
        _loadAccessToken();
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Text(
          'Loading Auth',
        ),
      );
    } else {
      return HomeLayout(accessToken: accssToken, child: new HomeScreen(title: widget.title));
    }
  }
}
