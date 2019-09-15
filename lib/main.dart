import 'package:acman_app/tabs/schedule.dart';
import 'package:acman_app/tabs/settings.dart';
import 'package:flutter/material.dart';
import 'tabs/events.dart';
import 'tabs/home.dart';

class BottomTabbarExample extends StatefulWidget {
  const BottomTabbarExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomTabbarExampleState();
}

class _BottomTabbarExampleState extends State<BottomTabbarExample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final _tabPages = <Widget>[
    HomeTab(),
    ScheduleTab(),
    EventsTab(),
    SettingsTab(),
  ];

  static const _tabs = <Tab>[
    Tab(icon: Icon(Icons.group_work), text: 'Main'),
    Tab(icon: Icon(Icons.event_note), text: 'Schedule'),
    Tab(icon: Icon(Icons.alarm), text: 'Events'),
    Tab(icon: Icon(Icons.build), text: 'Settings'),
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

void main() => runApp(new MaterialApp(home:Scaffold(body: BottomTabbarExample())));