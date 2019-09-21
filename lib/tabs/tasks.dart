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
        title: "Home",
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

  Future<Activity> currentActivities;
  Future<List<Activity>> onPausedActivities;
  AnimationController _controller;
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
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    List<AddListItem> items = [
      new AddListItem(
        text: "Консультацыя",
        color: Colors.greenAccent
      ),
      AddListItem(color: Colors.yellow, text: "Кофе")
    ];
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
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
                  ),
                ]
            )
        ),
      floatingActionButton: SpeedDial(
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
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(FontAwesomeIcons.user),
              backgroundColor: Colors.red,
              label: 'Консультация',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.coffee),
            backgroundColor: Colors.blue,
            label: 'Кофе',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.utensils),
            backgroundColor: Colors.green,
            label: 'Обед',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }
}

class AddListItem {
  Color color;
  String text;
  AddListItem({this.color, this.text});
}