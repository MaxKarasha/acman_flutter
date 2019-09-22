import 'dart:async';

import 'package:acman_app/api/bpm_api.dart';
import 'package:acman_app/model/activity.dart';

abstract class BaseAPI {
  Future<String> getOnPause();
  Future<String> getCurrent();
  Future<String> continueActivity(String data);
  Future<String> pauseCurrentActivity();
  Future<String> addActivity(String caption, String source);
  Future<String> addActivityItem(Activity activity);
  Future<String> stopActivity(String data);
  Future<String> stopCurrentActivity();
  Future<void> syncMe();

  factory BaseAPI() => BPMAPI();
}