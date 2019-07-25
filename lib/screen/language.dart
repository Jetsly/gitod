import 'package:flutter/material.dart';
import 'package:gitod/models/language.dart';
import 'package:gitod/models/utils.dart';
import 'package:gitod/provider/trend.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var trend = Provider.of<TrendModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Language"),
        ),
        body: ListView.separated(
            itemCount: trend.languages.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 4,
                  color: HexColor("#e1e4e8"),
                ),
            itemBuilder: (BuildContext context, int index) {
              Language lang = trend.languages[index];
              return ListTile(
                onTap: () async {
                  Navigator.of(context).pop(lang.urlParam);
                },
                title: Text(lang.name),
              );
            }));
  }
}
