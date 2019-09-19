import 'package:acman_app/tabs/schedule.dart';
import 'package:acman_app/tabs/settings.dart';
import 'package:acman_app/tabs/tasks.dart';
import 'package:flutter/material.dart';
import 'tabs/events.dart';
import 'tabs/home.dart';

void main() => runApp(new MaterialApp(home:Scaffold(body: BottomTabBarExample())));

class BottomTabBarExample extends StatefulWidget {
  const BottomTabBarExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomTabBarExampleState();
}

class _BottomTabBarExampleState extends State<BottomTabBarExample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final _tabPages = <Widget>[
    HomeTab(),
    TasksTab(),
    ScheduleTab(),
    EventsTab(),
    SettingsTab(),
  ];

  static const _tabs = <Tab>[
    Tab(icon: Icon(Icons.group_work), text: 'Главная'),
    Tab(icon: Icon(Icons.view_list), text: 'Активности'),
    Tab(icon: Icon(Icons.event_note), text: 'Расписание'),
    Tab(icon: Icon(Icons.alarm), text: 'События'),
    Tab(icon: Icon(Icons.build), text: 'Настройки'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabPages.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: TabBarView(
        children: _tabPages,
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: _tabs,
          controller: _tabController,
        ),
      ),
    );
  }
}