import 'package:flutter/material.dart';
import 'package:gitod/src/gitod_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gitod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: GitodHome(title: 'Gitod'),
    );
  }
}

