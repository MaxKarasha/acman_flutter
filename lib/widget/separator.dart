import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final String name;
  const Separator(this.name);

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            child: new Divider(
              color: Colors.black,
            )),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(name),
        ),
        new Expanded(
            child: new Divider(
              color: Colors.black,
            )),
      ],
    );
  }
}
