import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  String name;
  @JsonKey(name: "user_id")
  final int userId;
  final User user;
  List<Project> projects;
  List<Task> tasks;

  Category({
    this.id,
    this.createdAt,
    this.updateAt,
    this.name,
    this.userId,
    this.user,
    this.projects,
    this.tasks,
  });

  //stripped == operator, used only by service_controller when comparing objects after update call
  @override
  bool operator ==(cat) => cat is Category && id == cat.id;
  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updateAt.hashCode ^
      name.hashCode ^
      userId.hashCode ^
      user.hashCode ^
      projects.hashCode ^
      tasks.hashCode;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
