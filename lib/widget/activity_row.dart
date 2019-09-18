import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityRow extends StatelessWidget {
  final Activity activity;

  const ActivityRow(
      {Key key, this.activity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(activity.id.toString()),
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        child: ListTile(
          leading: const Icon(Icons.accessibility_new),
          onTap: () => _onTap(context, activity),
          title: Text(activity.caption),
          trailing: Text((new DateFormat('yyyy-MM-dd')).format(activity.start)),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, Activity activity) async {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ActivityPage(activity)));  }
}
