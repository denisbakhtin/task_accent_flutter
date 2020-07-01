import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'project.g.dart';

@JsonSerializable()
class Project {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  bool favorite;
  String name;
  String description;
  bool archived;
  @JsonKey(name: 'user_id')
  final int userId;
  final User user;
  @JsonKey(
      name: 'category_id', fromJson: jsonStringToInt, toJson: jsonIntToString)
  int categoryId;
  @JsonKey(name: 'files')
  List<AttachedFile> attachedFiles;
  List<Task> tasks;
  Category category;

  Project({
    this.id,
    this.createdAt,
    this.updateAt,
    this.favorite,
    this.name,
    this.description,
    this.archived,
    this.userId,
    this.user,
    this.categoryId,
    this.attachedFiles,
    this.tasks,
    this.category,
  });

  @override
  bool operator ==(proj) => proj is Project && id == proj.id;
  @override
  int get hashCode => id.hashCode;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
