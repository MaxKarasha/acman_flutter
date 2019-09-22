import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/separator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as prefix0;

class ActivityRowState extends State<ActivityRow> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void initState() {
    super.initState();
    _controller = new AnimationController(duration:
    const Duration(milliseconds: 246), vsync: this);

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );
  }

  void _move(DragUpdateDetails details) {
    final double delta = details.primaryDelta / 304;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value += delta;
        break;
      case TextDirection.ltr:
        _controller.value -= delta;
        break;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    bool _isFlingGesture = -details.velocity.pixelsPerSecond.dx > 600;

    if (_isFlingGesture) {
      final double flingVelocity = details.velocity.pixelsPerSecond.dx;
      _controller.fling(velocity: flingVelocity.abs() * 0.003333);
    } else if (_controller.value < 0.4) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.only(left: 4, right: 4, top: 4),
        child: GestureDetector(
          onDoubleTap: () => _openActivityPage(context, widget.activity),
          onHorizontalDragUpdate: _move,
          onHorizontalDragEnd: _handleDragEnd,
          child: new Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: new EdgeInsets.only(right: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [Colors.green, Colors.lightGreenAccent],
                            ),
                          ),
                          child: new IconButton(
                            padding: new EdgeInsets.only(top: 18.0, bottom: 18.0, left: 22.0, right: 22.0),
                            onPressed: () => _continueActivity(widget.activity),
                            icon: Icon(Icons.play_arrow),
                            iconSize: 28,
                            color: new Color(0xFFFFFFFF),
                          )
                      ),
                      new Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [Colors.amber, Colors.yellow],
                            ),
                          ),
                          child: new IconButton(
                            padding: new EdgeInsets.only(top: 18.0, bottom: 18.0, left: 22.0, right: 22.0),
                            icon: new Icon(Icons.done),
                            iconSize: 28,
                            color: new Color(0xFFFFFFFF),
                            onPressed: () { _stopActivity(widget.activity);},
                          )
                      ),
                      new Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [Colors.red, Colors.deepOrangeAccent],
                            ),
                          ),
                          child: new IconButton(
                            padding: new EdgeInsets.only(top: 18.0, bottom: 18.0, left: 22.0, right: 22.0),
                            icon: new Icon(Icons.edit),
                            iconSize: 28,
                            color: new Color(0xFFFFFFFF),
                            onPressed: () {_openActivityPage(context, widget.activity);},
                          )
                      ),
                    ],
                  ),
                )
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin:  Offset.zero,
                  end: const Offset(-0.565, 0.0), //controls the opening of the slice
                ).animate(_animation),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: SizedBox(
                        height: 100,
                        child: new Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: new NetworkImage(
                                      widget.activity.backgroundIconUrl
                                  ),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Row(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Center(
                                  child: new Padding(
                                    padding: new EdgeInsets.only(left: 10.0),
                                    child: new Container(
                                      child: Image.network(
                                        widget.activity.sourceIconUrl,
                                        height: 60,
                                        width: 60,
                                      ),
                                      decoration:BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                      ) ,
                                    ),
                                  )
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                                  child: ActivityDescription(
                                      activity: widget.activity
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  decoration: new BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 30.0
                        )
                      ]
                  ),
                ),
              ),
            ],
          )

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
    widget.notifyParent();
  }

  void _stopActivity(Activity activity) async {
    await ActivityRepository().stopActivity(activity);
    widget.notifyParent();
  }
}

class ActivityRow extends StatefulWidget {
  final Activity activity;
  final Function() notifyParent;

  @override
  ActivityRowState createState() => ActivityRowState();

  const ActivityRow(
      {Key key, this.activity, @required this.notifyParent})
      : super(key: key);


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
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              Visibility(
                child: Text(
                  'Начало: ' + new prefix0.DateFormat('yyyy-MM-dd HH:mm').format(activity.start ?? DateTime.now()),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black87,
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

