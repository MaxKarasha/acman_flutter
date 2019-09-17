import 'dart:async';

import 'package:acman_app/api/base_api.dart';
import 'package:http/http.dart';

const AcmanKey = 'TestMKKey';

class BPMAPI implements BaseAPI {
  @override
  Future<String> getOnPause() async {
    try {
      final response = await get(
          "http://10.0.2.2:54624/api/Activity/GetOnPause?AcmanKey=$AcmanKey");

      final jsonData = response.body;
      return jsonData;
    } catch (error) {
      throw error;
    }
  }
}