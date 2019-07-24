import 'package:flutter/material.dart';
import 'package:gitod/models/repository.dart';
import 'package:gitod/provider/trend.dart';
import 'package:gitod/widget/list_trend.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_picker/flutter_picker.dart';

class TrendingPage extends StatefulWidget {
  final String title;
  const TrendingPage({@required this.title});

  @override
  State<StatefulWidget> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    var trend = Provider.of<TrendModel>(context);
    if (trend.languages.isEmpty) {
      trend.fetchInit();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  new Picker(
                      adapter: PickerDataAdapter<int>(data: [
                        new PickerItem(
                            text: Text("daily"), value: TrendType.daily.index),
                        new PickerItem(
                            text: Text("weekly"),
                            value: TrendType.weekly.index),
                        new PickerItem(
                            text: Text("monthly"),
                            value: TrendType.monthly.index)
                      ]),
                      selecteds: [trend.type.index],
                      changeToFirst: true,
                      hideHeader: false,
                      onConfirm: (Picker picker, List<int> value) {
                        trend.fetchRepositories(
                            trendType: TrendType.values[value[0]]);
                      }).showModal(this.context);
                },
                icon: Icon(
                  Icons.calendar_today,
                ))
          ],
        ),
        body: trend.repositories.isEmpty
            ? Center(
                child: SpinKitCubeGrid(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ))
            : ListTrendWidget(repositories: trend.repositories));
  }
}
