import 'dart:async';

import 'package:acman_app/api/bpm_api.dart';

abstract class BaseAPI {
  Future<String> getOnPause();

  factory BaseAPI() => BPMAPI();
}