import 'package:flutter/material.dart';
import 'package:gitod/src/models/oauth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String accessToken;
  final String title;
  const HomeScreen({@required this.accessToken, @required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<Client> client = ValueNotifier(
      Client(
        endPoint: Oauth.endPoint,
        cache: InMemoryCache(),
        apiToken: widget.accessToken,
      ),
    );
    return GraphqlProvider(
        client: client,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Text(widget.accessToken),
        ));
  }
}
