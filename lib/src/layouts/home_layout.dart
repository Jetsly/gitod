import 'package:flutter/material.dart';
import 'package:gitod/src/models/oauth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeLayout extends StatelessWidget {
  final String accessToken;
  final Widget child;
  const HomeLayout({@required this.accessToken, @required this.child});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Client> client = ValueNotifier(
      Client(
        endPoint: Oauth.endPoint,
        cache: InMemoryCache(),
        apiToken: accessToken,
      ),
    );
    return GraphqlProvider(client: client, child: child);
  }
}
