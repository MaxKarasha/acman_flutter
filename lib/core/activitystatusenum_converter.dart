import 'package:acman_app/model/activity.dart';
import 'package:json_annotation/json_annotation.dart';

class ActivityStatusEnumConverter implements JsonConverter<ActivityStatusEnum, String> {
  const ActivityStatusEnumConverter();

  @override
  ActivityStatusEnum fromJson(dynamic json) {
    int valueIndex = int.parse(json);
    return ActivityStatusEnum.values.singleWhere((e) => e.index == valueIndex);
    //return _enumDecodeNullable(ActivityStatusEnumEnumMap, json);
  }

  @override
  //String toJson(ActivityStatusEnum json) => ActivityStatusEnumEnumMap[json];
  String toJson(ActivityStatusEnum json) => json.index.toString();

  _enumDecodeNullable<T>(Map<T, String> enumValues, String source) {
    if (source == null) {
      return null;
    }
    return _enumDecode<T>(enumValues, source);
  }

  T _enumDecode<T>(Map<T, String> enumValues, String source) {
    if (source == null) {
      throw ArgumentError('A value must be provided. Supported values: '
          '${enumValues.values.join(', ')}');
    }
    return enumValues.entries
        .singleWhere((e) => e.value == source,
        orElse: () => throw ArgumentError(
            '`$source` is not one of the supported values: '
                '${enumValues.values.join(', ')}'))
        .key;
  }
}

const ActivityStatusEnumEnumMap = <ActivityStatusEnum, String>{
  ActivityStatusEnum.New: '1',
  ActivityStatusEnum.InPause: '2',
  ActivityStatusEnum.InProgress: '3',
  ActivityStatusEnum.Done: '4'
};