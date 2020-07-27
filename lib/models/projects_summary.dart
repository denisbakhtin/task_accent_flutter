import 'package:json_annotation/json_annotation.dart';
part 'projects_summary.g.dart';

@JsonSerializable()
class ProjectsSummary {
  final int count;

  ProjectsSummary({this.count});

  @override
  bool operator ==(sum) => sum is ProjectsSummary && count == sum.count;
  @override
  int get hashCode => count.hashCode;

  factory ProjectsSummary.fromJson(Map<String, dynamic> json) =>
      _$ProjectsSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectsSummaryToJson(this);
}
