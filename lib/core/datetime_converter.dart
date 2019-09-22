import 'package:json_annotation/json_annotation.dart';

class AcmanDateTimeConverter implements JsonConverter<DateTime, String> {
  const AcmanDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json == null || json == "") return null;
    if (json.contains(".")) {
      //json = json.substring(0, json.length - 1);
      json = json.substring(0, json.indexOf('.'));
    }

    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime json) => json?.toIso8601String() ?? '';
}