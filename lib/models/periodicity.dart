import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'periodicity.g.dart';

//periodicity type constants
const int DONTREPEAT = 0;
const int DAILY = 1;
const int WEEKLY = 2;
const int MONTHLY = 3;
const int YEARLY = 4;

@JsonSerializable()
class Periodicity {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  @JsonKey(
      name: "periodicity_type",
      toJson: jsonIntToString,
      fromJson: jsonStringToInt)
  final int periodicityType; //see constants
  @JsonKey(name: "week_days")
  final int weekDays; //bitmask for days of week
  @JsonKey(name: "repeating_from", toJson: jsonDateTimeToISO)
  final DateTime repeatingFrom;
  @JsonKey(name: "repeating_to", toJson: jsonDateTimeToISO)
  final DateTime repeatingTo;
  final List<Task> tasks;
  @JsonKey(name: "user_id")
  final int userId;
  final User user;

  Periodicity({
    this.id,
    this.createdAt,
    this.updateAt,
    this.periodicityType,
    this.weekDays,
    this.repeatingFrom,
    this.repeatingTo,
    this.tasks,
    this.userId,
    this.user,
  });

  @override
  bool operator ==(per) => per is Periodicity && id == per.id;
  @override
  int get hashCode => id.hashCode;

  factory Periodicity.fromJson(Map<String, dynamic> json) =>
      _$PeriodicityFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodicityToJson(this);
}
