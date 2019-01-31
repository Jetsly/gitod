import 'package:flutter/material.dart';
import 'package:gitod/src/models/oauth.dart';
import 'package:gitod/src/models/event_bus.dart';
import 'package:gitod/src/screen/oauth_screen.dart';
import 'package:gitod/src/screen/home_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final InMemoryCache cache = InMemoryCache();

class GitodLoad extends StatefulWidget {
  GitodLoad({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _GitodLoadState();
}

class _GitodLoadState extends State<GitodLoad> {
  ValueNotifier<Client> client = ValueNotifier(
    Client(
      endPoint: Oauth.endPoint,
      cache: cache,
    ),
  );
  bool initialToken = true;
  bool cancelAuth = false;

  @override
  initState() {
    super.initState();
    EventBus.getInstance().on().listen((event) {
      Oauth.clearAccessToken().then((value) {
        this._loadAccessToken();
      });
    });
    _loadAccessToken();
  }

  _loadAccessToken() async {
    String token = await Oauth.getLocalAccessToken();
    if (token == null) {
      String code = await Navigator.of(context).push(MaterialPageRoute<String>(
          builder: (context) => OauthScreen(
              clientId: Oauth.clientId,
              redirectUrl: Oauth.redirectUrl,
              authorizeUrl: Oauth.authorizeUrl)));
      if (code == null) {
        return setState(() {
          cancelAuth = true;
        });
      }
      token = await Oauth.getRomoteAccessToken(code);
    }
    client.value.apiToken = token;
    setState(() {
      cancelAuth = false;
      initialToken = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cancelAuth) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: RaisedButton.icon(
                color: Theme.of(context).primaryColor,
                icon: Icon(
                  Icons.touch_app,
                  color: Colors.white,
                ),
                label: Text(
                  "Authorize",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _loadAccessToken();
                })),
      );
    } else if (initialToken) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: SpinKitCubeGrid(
          color: Colors.blue,
          size: 50.0,
        )),
      );
    } else {
      return GraphqlProvider(
          client: client,
          child: MaterialApp(
            title: 'Gitod',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.blue,
              primarySwatch: Colors.blue,
            ),
            home: new HomeScreen(title: widget.title),
          ));
    }
  }
}
