import 'package:flutter/material.dart';
import 'package:gitod/src/gitod_load.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gitod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GitodLoad(title: 'Gitod'),
    );
  }
}
