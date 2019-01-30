import 'package:flutter/material.dart';
import 'package:gitod/src/pages/home_repo.dart';
import 'package:gitod/src/pages/home_star.dart';
import 'package:gitod/src/pages/home_follower.dart';
import 'package:gitod/src/pages/home_following.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({@required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    HomeRepo(),
    HomeStar(),
    HomeFollower(),
    HomeFollowing(),
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
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.storage), title: Text('repositories')),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('stars')),
            BottomNavigationBarItem(
                icon: Icon(Icons.recent_actors), title: Text('follower')),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), title: Text('following')),
          ],
        ));
  }
}
