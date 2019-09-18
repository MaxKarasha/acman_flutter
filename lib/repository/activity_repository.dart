import 'dart:async';
import 'dart:convert';

import 'package:acman_app/api/base_api.dart';
import 'package:acman_app/model/activity.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getOnPause();

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
    ////Activity activity = new Activity.fromMap(jsonResponse);
    List<Activity> activities = jsonResponse.map<Activity>((i) => Activity.fromMap(i)).toList();
    return activities;
  }
}