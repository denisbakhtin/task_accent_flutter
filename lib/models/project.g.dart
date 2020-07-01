// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    id: json['id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    favorite: json['favorite'] as bool,
    name: json['name'] as String,
    description: json['description'] as String,
    archived: json['archived'] as bool,
    userId: json['user_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    categoryId: jsonStringToInt(json['category_id'] as String),
    attachedFiles: (json['files'] as List)
        ?.map((e) =>
            e == null ? null : AttachedFile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tasks: (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updateAt?.toIso8601String(),
      'favorite': instance.favorite,
      'name': instance.name,
      'description': instance.description,
      'archived': instance.archived,
      'user_id': instance.userId,
      'user': instance.user,
      'category_id': jsonIntToString(instance.categoryId),
      'files': instance.attachedFiles,
      'tasks': instance.tasks,
      'category': instance.category,
    };
