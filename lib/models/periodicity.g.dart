// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periodicity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Periodicity _$PeriodicityFromJson(Map<String, dynamic> json) {
  return Periodicity(
    id: json['id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    periodicityType: jsonStringToInt(json['periodicity_type'] as String),
    weekDays: json['week_days'] as int,
    repeatingFrom: json['repeating_from'] == null
        ? null
        : DateTime.parse(json['repeating_from'] as String),
    repeatingTo: json['repeating_to'] == null
        ? null
        : DateTime.parse(json['repeating_to'] as String),
    tasks: (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userId: json['user_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PeriodicityToJson(Periodicity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updateAt?.toIso8601String(),
      'periodicity_type': jsonIntToString(instance.periodicityType),
      'week_days': instance.weekDays,
      'repeating_from': jsonDateTimeToISO(instance.repeatingFrom),
      'repeating_to': jsonDateTimeToISO(instance.repeatingTo),
      'tasks': instance.tasks,
      'user_id': instance.userId,
      'user': instance.user,
    };
