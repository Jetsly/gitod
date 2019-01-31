import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RepoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RepoScreenState();
}

class _RepoScreenState extends State<RepoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitCubeGrid(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      )),
    );
  }
}
