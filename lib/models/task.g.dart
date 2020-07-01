// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    name: json['name'] as String,
    description: json['description'] as String,
    startDate: json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    endDate: json['end_date'] == null
        ? null
        : DateTime.parse(json['end_date'] as String),
    periodicityId: json['periodicity_id'] as int,
    periodicity: json['periodicity'] == null
        ? null
        : Periodicity.fromJson(json['periodicity'] as Map<String, dynamic>),
    completed: json['completed'] as bool,
    priority: jsonStringToInt(json['priority'] as String),
    projectId: jsonStringToInt(json['project_id'] as String),
    project: json['project'] == null
        ? null
        : Project.fromJson(json['project'] as Map<String, dynamic>),
    categoryId: jsonStringToInt(json['category_id'] as String),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    userId: json['user_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    comments: (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    taskLogs: (json['task_logs'] as List)
        ?.map((e) =>
            e == null ? null : TaskLog.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attachedFiles: (json['files'] as List)
        ?.map((e) =>
            e == null ? null : AttachedFile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updateAt?.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'start_date': jsonDateTimeToISO(instance.startDate),
      'end_date': jsonDateTimeToISO(instance.endDate),
      'periodicity_id': instance.periodicityId,
      'periodicity': instance.periodicity,
      'completed': instance.completed,
      'priority': jsonIntToString(instance.priority),
      'project_id': jsonIntToString(instance.projectId),
      'project': instance.project,
      'category_id': jsonIntToString(instance.categoryId),
      'category': instance.category,
      'user_id': instance.userId,
      'user': instance.user,
      'comments': instance.comments,
      'task_logs': instance.taskLogs,
      'files': instance.attachedFiles,
    };
