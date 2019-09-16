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
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ListTile(
          onTap: () => _onTap(context, activity),
          title: Text(activity.title),
          trailing: Text((new DateFormat('yyyy-MM-dd')).format(activity.startDate)),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, Activity activity) async {
    return;
  }
}
