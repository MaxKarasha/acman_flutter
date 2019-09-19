// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    id: json['id'] as String,
    caption: json['caption'] as String,
    start: const AcmanDateTimeConverter().fromJson(json['start'] as String),
    end: const AcmanDateTimeConverter().fromJson(json['end'] as String),
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'start': const AcmanDateTimeConverter().toJson(instance.start),
      'end': const AcmanDateTimeConverter().toJson(instance.end),
      'userId': instance.userId,
    };
