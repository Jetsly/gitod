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
    child: MaterialApp(
        initialRoute: "/",
        routes: {
          '/': (context) => HomeScreen(),
          '/search': (context) => SearchScreen(),
          '/language': (context) => LanguageScreen(),
        },
        title: 'Gitod',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        )),
  ));
}
