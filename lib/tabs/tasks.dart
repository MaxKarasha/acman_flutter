import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/activity_row.dart';
import 'package:acman_app/widget/current_activity_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

class _TasksPageState extends State<TasksPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Container(
            child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: ActivityRepository().getCurrent(),
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
                      future: ActivityRepository().getOnPause(),
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
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Добавить активность',
          child: const Icon(Icons.add),

        )
    );
  }
}