// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attached_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachedFile _$AttachedFileFromJson(Map<String, dynamic> json) {
  return AttachedFile(
    id: json['id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    ownerId: json['owner_id'] as int,
    ownerType: json['owner_type'] as String,
    userId: json['user_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    name: json['name'] as String,
    filePath: json['file_path'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$AttachedFileToJson(AttachedFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updateAt?.toIso8601String(),
      'owner_id': instance.ownerId,
      'owner_type': instance.ownerType,
      'user_id': instance.userId,
      'user': instance.user,
      'name': instance.name,
      'file_path': instance.filePath,
      'url': instance.url,
    };
