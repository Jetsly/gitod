import 'package:flutter/material.dart';
import 'package:gitod/models/repository.dart';
import 'package:gitod/provider/trend.dart';
import 'package:gitod/widget/list_trend.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TrendingPage extends StatefulWidget {
  final String title;
  const TrendingPage({@required this.title});

  @override
  State<StatefulWidget> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  Widget buildTabBarView(BuildContext context, TrendType trendType) {
    var trend = Provider.of<TrendModel>(context);
    if (trend.repositories[trendType] == null) {
      return Center(
          child: SpinKitCubeGrid(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      ));
    }
    return ListTrendWidget(repositories: trend.repositories[trendType]);
  }

  @override
  Widget build(BuildContext context) {
    var trend = Provider.of<TrendModel>(context);
    if (trend.languages.isEmpty) {
      trend.fetchInit();
    }
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: TabBar(
                tabs: <Widget>[
                  Tab(text: 'Today'),
                  Tab(text: 'This week'),
                  Tab(text: 'This month')
                ],
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    onPressed: () async {
                      var lang =
                          await Navigator.pushNamed(context, '/language');
                      if (lang != null) {
                        trend.fetchAllRepositories(language: lang);
                      }
                    },
                    icon: Icon(
                      Icons.language,
                    ))
              ],
            ),
            body: TabBarView(children: <Widget>[
              buildTabBarView(context, TrendType.daily),
              buildTabBarView(context, TrendType.weekly),
              buildTabBarView(context, TrendType.monthly),
            ])));
  }
}
