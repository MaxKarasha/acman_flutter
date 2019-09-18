import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/activity_row.dart';
import 'package:acman_app/widget/current_activity_row.dart';
import 'package:acman_app/widget/separator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Home",
        home: new MainHomePage(title: 'Текущие активности')
        //home: new Container()
    );
  }
}

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainHomePageState createState() => new _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

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
              builder: (BuildContext context, AsyncSnapshot<Activity> snapshot){
                if(snapshot.data == null){
                  return Container(
                      child: Center(
                          child: Text("Загрузка...")
                      )
                  );
                } else {
                  return CurrentActivityRow(
                    activity: snapshot.data,
                  );
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
                            child: Text("Загрузка...")
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