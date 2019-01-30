import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class OauthScreen extends StatefulWidget {
  final String clientId;
  final String redirectUrl;
  final String authorizeUrl;

  const OauthScreen(
      {@required this.clientId,
      @required this.redirectUrl,
      @required this.authorizeUrl});

  @override
  _OauthScreenState createState() => _OauthScreenState();
}

class _OauthScreenState extends State<OauthScreen> {
  bool setupUrlChangedListener = false;

  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    final clientId = widget.clientId;
    final redirectUrl = widget.redirectUrl;
    final authorizeUrl = widget.authorizeUrl;
    final scope = Uri.encodeComponent("notification,gist,user,repo");
    final url =
        "$authorizeUrl?scope=$scope&client_id=$clientId&redirect_uri=$redirectUrl";
    if (!setupUrlChangedListener) {
      flutterWebviewPlugin.onUrlChanged.listen((String changedUrl) async {
        if (changedUrl.startsWith(widget.redirectUrl)) {
          Uri uri = Uri().resolve(changedUrl);
          String code = uri.queryParameters["code"];
          Navigator.of(context).pop(code);
        }
      });
      setupUrlChangedListener = true;
    }
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Log in with Github"),
      ),
      url: url,
    );
  }
}
