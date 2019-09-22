import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentActivityRow extends StatelessWidget {
  final Activity activity;
  final Function() notifyParent;

  const CurrentActivityRow(
      {Key key, this.activity, @required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () => _openActivityPage(context, activity),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: SizedBox(
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new NetworkImage(
                          'https://i.pinimg.com/564x/19/33/3e/19333ed2c51f655ff0aac5fa365cb51a.jpg',
                        ),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 2.0, 2.0),
                        child: ActivityDescription(
                            activity: activity,
                            dark: true
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.pause_circle_outline, color: Colors.white70),
                              splashColor: Colors.green,
                              iconSize: 42,
                              onPressed: () => _pauseCurrentActivity(),
                            ),
                            /*IconButton(
                          icon: Icon(Icons.done_all, color: Colors.green),
                          splashColor: Colors.green,
                          iconSize: 42,
                          onPressed: () => _stopCurrentActivity(),
                        )*/
                            RaisedButton.icon(
                              onPressed: () => _stopCurrentActivity(),
                              icon: Icon(Icons.done, color: Colors.white),
                              label: Text('Done', style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white
                              )),
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              color: Colors.white30,
                            )
                          ],
                        )
                    )
                  ],
                ),
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
    await ActivityRepository().pauseCurrentActivity();
    notifyParent();
  }

  void _stopCurrentActivity() async {
    await ActivityRepository().stopCurrentActivity();
    notifyParent();
  }
}

class ActivityDescription extends StatelessWidget {

  const ActivityDescription({Key key, this.activity, this.dark = false}) : super(key: key);

  final Activity activity;
  final bool dark;
  Color get TextColor {
    return this.dark ? Colors.white : Colors.black;
  }
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: TextColor
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 12.0)),
              Text(
                "Статус: " + activity.statusName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  color: TextColor
                ),
              ),
              Visibility(
                child: Text(
                  'Начало: ' + new DateFormat('yyyy-MM-dd HH:mm').format(activity.start ?? DateTime.now()),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                  fontSize: 14.0,
                  color: TextColor,
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
