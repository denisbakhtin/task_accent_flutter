import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  String contents;
  @JsonKey(name: "is_solution")
  bool isSolution;
  @JsonKey(name: "user_id")
  final int userId;
  final User user;
  @JsonKey(name: "task_id")
  final int taskId;
  final Task task;
  @JsonKey(name: "files")
  List<AttachedFile> attachedFiles;

  Comment({
    this.id,
    this.createdAt,
    this.updateAt,
    this.contents,
    this.isSolution,
    this.userId,
    this.user,
    this.taskId,
    this.task,
    this.attachedFiles,
  });

  @override
  bool operator ==(comment) => comment is Comment && id == comment.id;
  @override
  int get hashCode => id.hashCode;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
