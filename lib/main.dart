import 'package:acman_app/tabs/events.dart';
import 'package:acman_app/tabs/schedule.dart';
import 'package:acman_app/tabs/tasks.dart';
import 'package:acman_app/widget/app_bar_acman.dart';

import 'tabs/settings.dart';
import 'widget/fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AcmanAppBar(
        height: 100,
      ),*/
      body: Container(
        //decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.view_list, title: "Активности"),
          TabData(iconData: Icons.event_note, title: "Расписание"),
          TabData(iconData: Icons.alarm, title: "События"),
          TabData(iconData: Icons.build, title: "Настройки")
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      )
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0: return TasksTab();
      case 1: return ScheduleTab();
      case 2: return EventsTab();
      default: SettingsTab();
    }
  }
}
