// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    contents: json['contents'] as String,
    isSolution: json['is_solution'] as bool,
    userId: json['user_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    taskId: json['task_id'] as int,
    task: json['task'] == null
        ? null
        : Task.fromJson(json['task'] as Map<String, dynamic>),
    attachedFiles: (json['files'] as List)
        ?.map((e) =>
            e == null ? null : AttachedFile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updateAt?.toIso8601String(),
      'contents': instance.contents,
      'is_solution': instance.isSolution,
      'user_id': instance.userId,
      'user': instance.user,
      'task_id': instance.taskId,
      'task': instance.task,
      'files': instance.attachedFiles,
    };
