import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Me'),
      ),
      body: Center(
        child: DropdownButton<String>(
          value: 'One',
          onChanged: (String newValue) {},
          items: <String>[
            'One',
            'Two',
            'Free',
            'Four',
            'Free',
            'Four',
            'Free',
            'Four'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
