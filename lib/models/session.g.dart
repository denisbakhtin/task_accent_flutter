// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    id: json['id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    contents: json['contents'] as String,
    userId: json['user_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    taskLogs: (json['task_logs'] as List)
        ?.map((e) =>
            e == null ? null : TaskLog.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updateAt?.toIso8601String(),
      'contents': instance.contents,
      'user_id': instance.userId,
      'user': instance.user,
      'task_logs': instance.taskLogs,
    };
