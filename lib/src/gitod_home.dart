import 'package:flutter/material.dart';

class GitodHome extends StatelessWidget {
  GitodHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Sign In',
        child: Icon(Icons.save),
      ),
    );
  }
}
