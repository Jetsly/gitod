import 'package:flutter/material.dart';
import 'package:gitod/models/repository.dart';
import 'package:gitod/models/utils.dart';
import 'package:gitod/provider/trend.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<TrendModel>(builder: (context, trend, child) {
      if (trend.languages.isEmpty || trend.repositories.isEmpty) {
        trend.fetchLanguage();
        trend.fetchRepositories(since: Since.daily);
        return Center(
            child: SpinKitCubeGrid(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ));
      }
      return ListView.separated(
          itemCount: trend.repositories.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: 2.5,
                color: HexColor("#eaecef"),
              ),
          itemBuilder: (BuildContext context, int index) {
            Repository node = trend.repositories[index];
            var hasLang = node.languageColor != null && node.language != null;
            var color = HexColor("#586069");
            return Container(
              color: null,
              child: ListTile(
                contentPadding: EdgeInsets.all(6),
                onTap: () {},
                title: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(node.name,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              ))),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    children: <Widget>[
                      ...node.description.length > 0
                          ? [
                              Container(
                                  padding: EdgeInsets.fromLTRB(2, 0, 0, 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(node.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3))
                            ]
                          : [],
                      Row(children: () {
                        return <Widget>[
                          ...hasLang
                              ? [
                                  Icon(Icons.lens,
                                      size: 15,
                                      color: HexColor(node.languageColor)),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                      child: Text(node.language,
                                          style: TextStyle(color: color)))
                                ]
                              : [],
                          Icon(Icons.star, size: 18, color: color),
                          Padding(
                              padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                              child: Text(node.stars.toString(),
                                  style: TextStyle(color: color))),
                          Icon(Icons.share, size: 15, color: color),
                          Padding(
                              padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                              child: Text(node.forks.toString(),
                                  style: TextStyle(color: color))),
                        ];
                      }())
                    ],
                  ),
                ),
              ),
            );
          });
    }));
  }
}
