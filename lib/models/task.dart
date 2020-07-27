import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'task.g.dart';

const PRIORITY1 = 1; //top
const PRIORITY2 = 2;
const PRIORITY3 = 3;
const PRIORITY4 = 4; //last

@JsonSerializable()
class Task {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  String name;
  String description;
  @JsonKey(name: "start_date", toJson: jsonDateTimeToISO)
  DateTime startDate;
  @JsonKey(name: "end_date", toJson: jsonDateTimeToISO)
  DateTime endDate;
  @JsonKey(name: "periodicity_id")
  int periodicityId;
  Periodicity periodicity;
  bool completed;
  @JsonKey(fromJson: jsonStringToInt, toJson: jsonIntToString)
  int priority;
  @JsonKey(
      name: "project_id", fromJson: jsonStringToInt, toJson: jsonIntToString)
  int projectId;
  Project project;
  @JsonKey(
      name: "category_id", fromJson: jsonStringToInt, toJson: jsonIntToString)
  int categoryId;
  Category category;
  @JsonKey(name: "user_id")
  final int userId;
  final User user;
  List<Comment> comments;
  @JsonKey(name: "task_logs")
  List<TaskLog> taskLogs;
  @JsonKey(name: "files")
  List<AttachedFile> attachedFiles;

  Task({
    this.id,
    this.createdAt,
    this.updateAt,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.periodicityId,
    this.periodicity,
    this.completed,
    this.priority,
    this.projectId,
    this.project,
    this.categoryId,
    this.category,
    this.userId,
    this.user,
    this.comments,
    this.taskLogs,
    this.attachedFiles,
  });

  @override
  bool operator ==(task) => task is Task && id == task.id;
  @override
  int get hashCode => id.hashCode;

  bool get isExpired =>
      completed == false && endDate != null && endDate.isBefore(DateTime.now());

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
