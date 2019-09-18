import 'package:acman_app/model/activity.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {

  final Activity activity;

  ActivityPage(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(activity.caption),
        )
    );
  }
}