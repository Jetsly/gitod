import 'package:flutter/material.dart';

import 'package:gitod/pages/trend.dart';
import 'package:gitod/pages/favorite.dart';
import 'package:gitod/pages/me.dart';

import 'package:gitod/screen/search.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({@required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    TrendingPage(),
    FavoritePage(),
    MePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<String>(
                      builder: (context) => SearchScreen()));
                },
                icon: Icon(
                  Icons.search,
                ))
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.whatshot), title: Text('Trending')),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text('Favorite')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Me')),
          ],
        ));
  }
}
