import 'package:acman_app/card/ActivityPage.dart';
import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/activity_row.dart';
import 'package:acman_app/widget/separator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatelessWidget {
  List<Activity> activities = new List<Activity>.generate(20, (i) { return Activity(caption: "Activity $i", start: DateTime.now());});
  //List<Activity> activities2 = await ActivityRepository().getOnPause();

  /*@override
  void initState() async {
    activities2 = await ActivityRepository().getOnPause();
  }*/

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
        child: FutureBuilder(
          future: ActivityRepository().getOnPause(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
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
                  /*return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data[index].picture
                      ),
                    ),
                    title: Text(snapshot.data[index].caption),
                    subtitle: Text(new DateFormat('yyyy-MM-dd').format(snapshot.data[index].start)),
                    onTap: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => ActivityPage(snapshot.data[index]))
                      );
                    },
                  );*/
                },
              );
            }
          },
        ),
      ),
    );
  }
}