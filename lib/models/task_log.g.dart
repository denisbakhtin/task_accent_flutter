// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskLog _$TaskLogFromJson(Map<String, dynamic> json) {
  return TaskLog(
    id: json['id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    taskId: json['task_id'] as int,
    task: json['task'] == null
        ? null
        : Task.fromJson(json['task'] as Map<String, dynamic>),
    minutes: json['minutes'] as int,
    commited: json['commited'] as bool,
    userId: json['user_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    sessionId: json['session_id'] as int,
    session: json['session'] == null
        ? null
        : Session.fromJson(json['session'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TaskLogToJson(TaskLog instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updateAt?.toIso8601String(),
      'task_id': instance.taskId,
      'minutes': instance.minutes,
      'commited': instance.commited,
      'user_id': instance.userId,
      'user': instance.user,
      'task': instance.task,
      'session_id': instance.sessionId,
      'session': instance.session,
    };
