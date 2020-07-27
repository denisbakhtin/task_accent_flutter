import 'package:json_annotation/json_annotation.dart';
part 'tasks_summary.g.dart';

@JsonSerializable()
class TasksSummary {
  final int count;

  TasksSummary({this.count});

  @override
  bool operator ==(sum) => sum is TasksSummary && count == sum.count;
  @override
  int get hashCode => count.hashCode;

  factory TasksSummary.fromJson(Map<String, dynamic> json) =>
      _$TasksSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$TasksSummaryToJson(this);
}
