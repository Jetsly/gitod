import 'package:flutter/material.dart';
import 'package:gitod/src/models/oauth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:gitod/src/widget/git_repo.dart';

class HomeScreen extends StatefulWidget {
  final String accessToken;
  final String title;
  const HomeScreen({@required this.accessToken, @required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _widgetOptions = [RepoWidget()];

  BottomNavigationBar _buildNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.storage), title: Text('repo')),
        BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('star')),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: _buildNavBar(context)));
  }
}
