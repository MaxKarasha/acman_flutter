import 'dart:async';

import 'package:acman_app/api/bpm_api.dart';
import 'package:acman_app/model/activity.dart';

abstract class BaseAPI {
  Future<String> getOnPause();
  Future<String> continueActivity(String data);

  factory BaseAPI() => BPMAPI();
}