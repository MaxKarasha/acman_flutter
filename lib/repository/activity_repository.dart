import 'dart:async';
import 'dart:async' as prefix0;
import 'dart:convert';

import 'package:acman_app/api/base_api.dart';
import 'package:acman_app/model/activity.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getOnPause();
  Future<Activity> getCurrent();
  Future<Activity> continueActivity(Activity activity);
  Future<Activity> pauseCurrentActivity();
  Future<Activity> stopActivity(Activity activity);
  Future<Activity> addActivity(String caption, String source);
  Future<Activity> addActivityItem(Activity activity);
  Future<Activity> stopCurrentActivity();
  Future<void> syncMe();

  factory ActivityRepository() => ActivityRepositoryBPMApi();
}

class ActivityRepositoryBPMApi implements ActivityRepository {
  final _api = BaseAPI();
  static final ActivityRepositoryBPMApi _repositoryImpl = ActivityRepositoryBPMApi._internal();

  factory ActivityRepositoryBPMApi() => _repositoryImpl;

  ActivityRepositoryBPMApi._internal();

  @override
  Future<List<Activity>> getOnPause() async {
    //List<Activity> activities = new List<Activity>.generate(20, (i) { return Activity(caption: "Activity $i", start: DateTime.now());});
    final jsonData = await _api.getOnPause();
    final jsonResponse = json.decode(jsonData);
    List<Activity> activities = jsonResponse.map<Activity>((i) => Activity.fromJson(i)).toList();
    return activities;
  }

  Future<Activity> getCurrent() async {
    //return new Activity(caption: "Завершить проектирование архитектуры Автопланирования", start: DateTime.now());
    final jsonData = await _api.getCurrent();
    return _convertResponseToActivity(jsonData);
  }

  Future<Activity> continueActivity(Activity activity) async {
    final jsonData = await _api.continueActivity(jsonEncode(activity));
    return _convertResponseToActivity(jsonData);
  }

  Future<Activity> pauseCurrentActivity() async {
    final jsonData = await _api.pauseCurrentActivity();
    return _convertResponseToActivity(jsonData);
  }

  Future<Activity> addActivity(String caption, String source) async {
    final jsonData = await _api.addActivity(caption, source);
    return _convertResponseToActivity(jsonData);
  }

  Future<Activity> addActivityItem(Activity activity) async {
    final jsonData = await _api.addActivityItem(activity);
    return _convertResponseToActivity(jsonData);
  }

  Future<Activity> stopActivity(Activity activity) async {
    final jsonData = await _api.stopActivity(jsonEncode(activity));
    return _convertResponseToActivity(jsonData);
  }

  Future<Activity> stopCurrentActivity() async {
    final jsonData = await _api.stopCurrentActivity();
    return _convertResponseToActivity(jsonData);
  }

  Future<void> syncMe() async {
    final jsonData = await _api.stopCurrentActivity();
    return _convertResponseToActivity(jsonData);
  }

  Activity _convertResponseToActivity(String data) {
    return data.isEmpty ? null : Activity.fromJson(json.decode(data));
  }
}