import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/separator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityRow extends StatelessWidget {
  final Activity activity;
  final Function() notifyParent;

  const ActivityRow(
      {Key key, this.activity, @required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () => _openActivityPage(context, activity),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.arrow_forward_ios, size: 70, color: Colors.green),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: ActivityDescription(
                      activity: activity
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    /*IconButton(
                      icon: Icon(Icons.play_arrow, color: Colors.green),
                      iconSize: 34,
                      splashColor: Colors.green,
                      onPressed: () => _continueActivity(activity),
                    ),*/
                    RaisedButton.icon(
                      onPressed: () => _continueActivity(activity),
                      icon: Icon(Icons.play_arrow, color: Colors.green),
                      label: Text('Start'),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.yellow,
                    ),
                    /*IconButton(
                      icon: Icon(Icons.done_all, color: Colors.green),
                      splashColor: Colors.red,
                      iconSize: 34,
                      onPressed: () => _stopActivity(activity),
                    )*/
                    RaisedButton.icon(
                      onPressed: () => _stopActivity(activity),
                      icon: Icon(Icons.done, color: Colors.green),
                      label: Text('Done'),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.lightGreenAccent,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  void _openActivityPage(BuildContext context, Activity activity) async {
    Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => ActivityPage(activity))
    );
  }

  void _continueActivity(Activity activity) async {
    await ActivityRepository().continueActivity(activity);
    notifyParent();
  }

  void _stopActivity(Activity activity) async {
    await ActivityRepository().stopActivity(activity);
    notifyParent();
  }
}

class ActivityDescription extends StatelessWidget {

  const ActivityDescription({Key key, this.activity}) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                activity.caption,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 12.0)),
              Text(
                "Статус: " + activity.statusName,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              Visibility(
                child: Text(
                  'Начало: ' + new DateFormat('yyyy-MM-dd HH:mm').format(activity.start ?? DateTime.now()),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
                visible: activity.start != null,
              ),
            ],
          ),
        )
      ],
    );
  }
}
