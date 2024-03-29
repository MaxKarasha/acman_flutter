import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:acman_app/api/base_api.dart';
import 'package:acman_app/model/activity.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

const AcmanKey = 'TestMKKey';
const AcmanUri = 'https://acman-server-ff5.conveyor.cloud';
var uuid = new Uuid();

class BPMAPI implements BaseAPI {
  @override
  Future<String> getOnPause() async {
    return _baseGet("Activity", "GetOnPause");
    //final response = await get("http://www.json-generator.com/api/json/get/bTxpmlhBpe");
  }

  Future<String> getCurrent() async {
    return _baseGet("CurrentActivity", "GetCurrent");
  }

  @override
  Future<String> pauseCurrentActivity() async {
    return _basePost("CurrentActivity", "Pause", "");
  }

  @override
  Future<String> continueActivity(String data) async {
    return _basePost("Activity", "Continue", data);
  }

  @override
  Future<String> addActivity(String caption, String source) async {
    return addActivityItem(Activity(
        id: uuid.v1(),
        caption: caption,
        userId: "9A5A2215-B83F-4CB5-7351-08D5E1011293",
        start: DateTime.now(),
        end: null,
        status: ActivityStatusEnum.InProgress,
        source: source
    ));
  }
  Future<String> addActivityItem(Activity activity) async {
    final data = jsonEncode(activity.toJson());
    await _basePost("Activity", "Add", data);
    return data;
  }
  @override
  Future<String> stopActivity(String data) async {
    return _basePost("Activity", "Stop", data);
  }

  @override
  Future<String> stopCurrentActivity() async {
    return _basePost("CurrentActivity", "Stop", "");
  }

  Future<void> syncMe() async {
    return await _basePost("Synchronization", "SyncMe", "");
  }

  Future<String> _basePost(String controllerName, String methodName, String data) async {
    try {
      final response = await post(AcmanUri + "/api/$controllerName/$methodName?AcmanKey=$AcmanKey",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: data
      );
      return response.body;
    } catch (error) {
      throw error;
    }
  }

  Future<String> _baseGet(String controllerName, String methodName) async {
    try {
      final response = await get(AcmanUri + "/api/$controllerName/$methodName?AcmanKey=$AcmanKey");
      final jsonData = response.body;
      return jsonData;
    } catch (error) {
      throw error;
    }
  }
}