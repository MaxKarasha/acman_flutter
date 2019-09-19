import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:acman_app/api/base_api.dart';
import 'package:http/http.dart';

const AcmanKey = 'TestMKKey';
const AcmanUri = 'http://10.0.2.2:54624';

class BPMAPI implements BaseAPI {
  @override
  Future<String> getOnPause() async {
    try {
      //final response = await get(AcmanUri + "/api/Activity/GetOnPause?AcmanKey=$AcmanKey");
      final response = await get("http://www.json-generator.com/api/json/get/bTxpmlhBpe");
      final jsonData = response.body;
      return jsonData;
    } catch (error) {
      throw error;
    }
  };

  @override
  Future<String> continueActivity(String data) async {
    try {
      final response = await post('$AcmanUri',
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: data
      );
      return response.body;
    } catch (error) {
      throw error;
    }
  };
}