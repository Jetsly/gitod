import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gitod/provider/trend.dart';
import 'package:gitod/screen/home.dart';

void main() {
  final trend = TrendModel();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: trend)],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gitod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        title: "Gitod",
      ),
    );
  }
}
