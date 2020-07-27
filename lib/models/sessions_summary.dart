import 'package:json_annotation/json_annotation.dart';
part 'sessions_summary.g.dart';

@JsonSerializable()
class SessionsSummary {
  final int count;

  SessionsSummary({this.count});

  @override
  bool operator ==(sum) => sum is SessionsSummary && count == sum.count;
  @override
  int get hashCode => count.hashCode;

  factory SessionsSummary.fromJson(Map<String, dynamic> json) =>
      _$SessionsSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$SessionsSummaryToJson(this);
}
