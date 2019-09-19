import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';

class CurrentActivityRow extends StatelessWidget {
  final Activity activity;

  const CurrentActivityRow(
      {Key key, this.activity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () => _openActivityPage(context, activity),
          child: Card(
            color: Colors.lightGreenAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 2.0, 2.0),
                      child: ActivityDescription(
                          activity: activity
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.pause_circle_outline, color: Colors.green),
                          splashColor: Colors.green,
                          iconSize: 42,
                          onPressed: () => _pauseCurrentActivity(),
                        ),
                        IconButton(
                          icon: Icon(Icons.done_all, color: Colors.green),
                          splashColor: Colors.green,
                          iconSize: 42,
                          onPressed: () => _stopCurrentActivity(),
                        )
                      ],
                    )
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

  void _pauseCurrentActivity() async {
    ActivityRepository().pauseCurrentActivity();
  }

  void _stopCurrentActivity() async {
    ActivityRepository().stopCurrentActivity();
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
                  fontSize: 20,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 12.0)),
              Visibility(
                child: Text(
                  'Start date: ' + new DateFormat('yyyy-MM-dd HH:mm').format(activity.start ?? DateTime.now()),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                  fontSize: 14.0,
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
