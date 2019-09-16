import 'package:acman_app/model/activity.dart';
import 'package:acman_app/widget/activity_row.dart';
import 'package:acman_app/widget/separator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  static Activity a1 = new Activity("Test 1", DateTime.now());
  static Activity a2 = new Activity("Test 2", DateTime.now());
  static Activity a3 = new Activity("Test 3", DateTime.now());
  //List<Activity> activities = [a1,a2,a3];
  List<Activity> activities = new List<Activity>.generate(20, (i) { return Activity("Activity $i", DateTime.now());});

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Separator("Activities"),
              /*PausedList(
                items: List<String>.generate(10, (i) => "Item $i"),
              ),*/
              new Column(
                children: activities.map((activity) {
                  return ActivityRow(
                    activity: activity,
                  );
                }).toList(),
              ),
              Separator("END")
            ]
          )
        )
    );
  }
}

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