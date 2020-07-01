import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'session.g.dart';

@JsonSerializable()
class Session {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  String contents;
  @JsonKey(name: "user_id")
  final int userId;
  final User user;
  @JsonKey(name: "task_logs")
  List<TaskLog> taskLogs;

  Session({
    this.id,
    this.createdAt,
    this.updateAt,
    this.contents,
    this.userId,
    this.user,
    this.taskLogs,
  });

  @override
  bool operator ==(session) => session is Session && id == session.id;
  @override
  int get hashCode => id.hashCode;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
