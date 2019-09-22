import 'package:acman_app/card/NewActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {

  final Activity activity;

  ActivityPage(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(activity.caption),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: new NetworkImage(
                      this.activity.backgroundIconUrl,
                    ),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: MyActivityForm(
                    activity: this.activity
                  )
                ),
              ],
            ),
        ),
    );
  }
}
