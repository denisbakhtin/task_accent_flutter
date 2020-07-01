import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'attached_file.g.dart';

@JsonSerializable()
class AttachedFile {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updateAt;
  @JsonKey(name: "owner_id")
  final int ownerId;
  @JsonKey(name: "owner_type")
  final String ownerType;
  @JsonKey(name: "user_id")
  final int userId;
  final User user;
  final String name;
  @JsonKey(name: "file_path")
  final String filePath;
  final String url;

  AttachedFile({
    this.id,
    this.createdAt,
    this.updateAt,
    this.ownerId,
    this.ownerType,
    this.userId,
    this.user,
    this.name,
    this.filePath,
    this.url,
  });

  factory AttachedFile.fromJson(Map<String, dynamic> json) =>
      _$AttachedFileFromJson(json);
  Map<String, dynamic> toJson() => _$AttachedFileToJson(this);
}
