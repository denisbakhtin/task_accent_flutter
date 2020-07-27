import 'package:json_annotation/json_annotation.dart';
part 'categories_summary.g.dart';

@JsonSerializable()
class CategoriesSummary {
  final int count;

  CategoriesSummary({this.count});

  @override
  bool operator ==(sum) => sum is CategoriesSummary && count == sum.count;
  @override
  int get hashCode => count.hashCode;

  factory CategoriesSummary.fromJson(Map<String, dynamic> json) =>
      _$CategoriesSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesSummaryToJson(this);
}
