import 'package:flutter/material.dart';
import 'package:gitod/screen/language.dart';
import 'package:gitod/screen/search.dart';
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
      initialRoute: "/home",
      routes: {
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/language': (context) => LanguageScreen(),
      },
      title: 'Gitod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
