import 'package:acman_app/model/activity.dart';
import 'package:acman_app/repository/activity_repository.dart';
import 'package:acman_app/widget/activity_row.dart';
import 'package:acman_app/widget/separator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        home: Scaffold(
          appBar: AppBar(
              title: Text("Текущие активности")
          ),
          body: new Container(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: new SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Separator("Незавершенные"),


                    activityesListWidget(),
                    /*new Column(
                      children: activities.map((activity) {
                        return ActivityRow(
                          activity: activity,
                        );
                      }).toList(),
                    )*/
                  ]
                )
              )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        )
    );
  }
}

Widget activityesListWidget() {
  return FutureBuilder(
    builder: (context, activityInList) {
      if (activityInList.connectionState == ConnectionState.none &&
          activityInList.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return ListView.builder(
        itemCount: activityInList.data.length,
        itemBuilder: (context, index) {
          Activity activity = activityInList.data[index];
          return ActivityRow(
            activity: activity,
          );
        },
      );
    },
    future: ActivityRepository().getOnPause(),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('ProjectList'),
    ),
    body: activityesListWidget(),
  );
}

/*PausedList(
  items: List<String>.generate(10, (i) => "Item $i"),
),*/
class PausedList extends StatelessWidget {
  final List<String> items;

  PausedList({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${items[index]}'),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
      ),
    );
  }
}