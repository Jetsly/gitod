import 'package:flutter/material.dart';

class CodeScreen extends StatelessWidget {
  final String name;
  final String text;
  const CodeScreen({@required this.name, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Text(
            text,
          )),
    );
  }
}
