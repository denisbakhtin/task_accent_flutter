import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'task_log.g.dart';

@JsonSerializable()
class TaskLog {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  @JsonKey(name: "task_id")
  int taskId;
  int minutes;
  bool commited;
  @JsonKey(name: "user_id")
  final int userId;
  final User user;
  Task task;
  @JsonKey(name: "session_id")
  int sessionId;
  Session session;

  TaskLog({
    this.id,
    this.createdAt,
    this.updateAt,
    this.taskId,
    this.task,
    this.minutes,
    this.commited,
    this.userId,
    this.user,
    this.sessionId,
    this.session,
  });

  factory TaskLog.fromTask(Task task) =>
      TaskLog(task: task, taskId: task.id, minutes: 0);

  factory TaskLog.fromJson(Map<String, dynamic> json) =>
      _$TaskLogFromJson(json);
  Map<String, dynamic> toJson() => _$TaskLogToJson(this);
}
