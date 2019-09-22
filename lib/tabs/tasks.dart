import 'package:acman_app/api/bpm_api.dart';
import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/card/NewActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/activity_row.dart';
import 'package:acman_app/widget/current_activity_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Активности",
        home: new TasksPage(title: 'Текущие активности')
      //home: new Container()
    );
  }
}

class TasksPage extends StatefulWidget {
  TasksPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TasksPageState createState() => new _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin  {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Future<Activity> currentActivities;
  Future<List<Activity>> onPausedActivities;
  AnimationController _controller;
  bool showSpeedDial = true;
  @override
  void initState() {
    super.initState();
    currentActivities = ActivityRepository().getCurrent();
    onPausedActivities = ActivityRepository().getOnPause();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }
  refreshData() {
    setState(() {
      currentActivities = ActivityRepository().getCurrent();
      onPausedActivities = ActivityRepository().getOnPause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
        appBar: AppBar(
            title: Text("Acman tasks"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {_syncMe();},
              ),
            ]
        ),
        body: Container(
            child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: currentActivities,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.connectionState != ConnectionState.done){
                        return Container(
                            child: Center(
                                //child: Text("Загрузка...")
                                child: new LinearProgressIndicator()
                            )
                        );
                      } else {
                        if (snapshot.data != null) {
                          return CurrentActivityRow(
                            activity: snapshot.data,
                            notifyParent: refreshData
                          );
                        } else {
                          return Container();
                        }
                      }
                    },
                  ),
                  //Separator('Незавершенные активности'),
                  Expanded(
                    flex: 4,
                    child: new RefreshIndicator(
                        key: _refreshIndicatorKey,
                        child: FutureBuilder(
                          future: onPausedActivities,
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.data == null){
                              return Container(
                                  child: Center(
                                    //child: Text("Загрузка...")
                                      child: new RefreshProgressIndicator()
                                  )
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ActivityRow(
                                      activity: snapshot.data[index],
                                      notifyParent: refreshData
                                  );
                                },
                              );
                            }
                          },
                        ),
                        onRefresh: () {
                            refreshData();
                            return currentActivities;
                        })
                  ),
                ]
            )
        ),
      floatingActionButton: this.showSpeedDial ? SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(FontAwesomeIcons.user),
              backgroundColor: Colors.red,
              label: 'Консультация',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => ActivityRepository().addActivity("Консультация", "help")
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.coffee),
            backgroundColor: Colors.blue,
            label: 'Кофе',
            labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => ActivityRepository().addActivity("Кофе", "coffee")
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.utensils),
            backgroundColor: Colors.green,
            label: 'Обед',
            labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => ActivityRepository().addActivity("Обед", "lunch")
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.plus),
            backgroundColor: Colors.green,
            label: 'Другое',
            labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
//                bottomSheetController.closed.then((value) {
//                  showFoatingActionButton(true);
//                });
                var newActivity = new Activity(
                    id: uuid.v1(),
                    caption: "",
                    userId: "9A5A2215-B83F-4CB5-7351-08D5E1011293",
                    start: DateTime.now(),
                    status: ActivityStatusEnum.InProgress,
                    source: "phone"
                );
                var scheetController = scaffoldKey.currentState.showBottomSheet((context) => Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
                        ]),
                    height: 250,
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                            title: MyActivityForm(
                                activity: newActivity
                            )
                        ),
                        ListTile(
                          title: MaterialButton(
                            color: Colors.grey[800],
                            onPressed: () {
                              ActivityRepository().addActivityItem(newActivity);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Создать',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        )
                      ],
                    )
                ));
                showSpeedDialButton(false);
                scheetController.closed.then((val) => showSpeedDialButton(true));
              }
          ),
        ],
      ) : Container(),
    );
  }
  void showSpeedDialButton(bool val) {
    setState(() {
      showSpeedDial = val;
    });
  }
  void _syncMe() async {
    await ActivityRepository().syncMe();
    refreshData();
  }
}

class AddListItem {
  Color color;
  String text;
  AddListItem({this.color, this.text});
}