import 'package:flutter/material.dart';
import 'package:gitod/src/pages/home/home_repo.dart';
import 'package:gitod/src/pages/home/home_star.dart';

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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.storage), title: Text('repo')),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('star')),
          ],
        ));
  }
}
