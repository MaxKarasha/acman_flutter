import 'package:acman_app/core/activitystatusenum_converter.dart';
import 'package:acman_app/core/datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

enum ActivityStatusEnum {
  New,
  InPause,
  InProgress,
  Done
}

Map<ActivityStatusEnum, String> ActivityStatusEnumMap  = {
  ActivityStatusEnum.New: "Не начата",
  ActivityStatusEnum.InPause: "Пауза",
  ActivityStatusEnum.InProgress: "В работе",
  ActivityStatusEnum.Done: "Завершена"
};

@AcmanDateTimeConverter()
//@ActivityStatusEnumConverter()
@JsonSerializable()
class Activity {

  String id;

  String caption;

  DateTime start;

  DateTime end;

  String userId;

  String source;

  String sourceIcon;

  String backgroundIcon;
  @JsonKey(fromJson: _ActivityStatusEnumFromJson, toJson: _ActivityStatusEnumToJson)
  ActivityStatusEnum status;

  String get statusName => ActivityStatusEnumMap[status];

  String get sourceIconUrl => sourceIcon ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Telegram_2019_Logo.svg/1200px-Telegram_2019_Logo.svg.png";

  String get backgroundIconUrl => backgroundIcon == null || backgroundIcon == "" ? "https://i.pinimg.com/564x/5c/cd/75/5ccd7544f3908ca293f66e9b186015df.jpg" : backgroundIcon;

  Activity({this.id, this.caption, this.start, this.end, this.userId, this.status, this.source, this.sourceIcon, this.backgroundIcon});

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  /*Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'caption': this.caption,
      'start': this.start,
      'end': this.end,
      'userId': this.userId
    };
  }*/

  /*factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as String,
      caption: map['caption'] as String,
      start: map['start'] != null ? DateTime.parse(map['start']) : DateTime.now(),
      end: map['end'] != null ? DateTime.parse(map['end']) : DateTime.now(),
      userId: map['userId'] as String
      //articles: map['articles'].map<Article>((article) => Article.fromMap(article)).toList(),
    );
  }*/

}

ActivityStatusEnum _ActivityStatusEnumFromJson (dynamic json) {
  int valueIndex = int.parse(json.toString());
  return ActivityStatusEnum.values.singleWhere((e) => e.index == valueIndex);
  //return _enumDecodeNullable(ActivityStatusEnumEnumMap, json);
}

dynamic _ActivityStatusEnumToJson(ActivityStatusEnum json) => json.index;