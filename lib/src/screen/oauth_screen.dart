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
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override 
  initState() {
    super.initState();
    flutterWebviewPlugin.onHttpError.listen((error){
      Scaffold.of(context).showSnackBar(SnackBar(content:Text('aaa')));
    });
    flutterWebviewPlugin.onUrlChanged.listen((String changedUrl) {
      if (changedUrl.startsWith(widget.redirectUrl)) {
        Uri uri = Uri().resolve(changedUrl);
        String code = uri.queryParameters["code"];
        Navigator.of(context).pop(code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientId = widget.clientId;
    final redirectUrl = widget.redirectUrl;
    final authorizeUrl = widget.authorizeUrl;
    final scope = Uri.encodeComponent("notification,gist,user,repo");
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Log in with Github"),
      ),
      url:
          "$authorizeUrl?scope=$scope&client_id=$clientId&redirect_uri=$redirectUrl",
      userAgent:
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36',
    );
  }
}
