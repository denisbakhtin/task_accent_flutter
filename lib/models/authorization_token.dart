import 'package:json_annotation/json_annotation.dart';

part 'authorization_token.g.dart';

@JsonSerializable()
class AuthorizationToken {
  String token;
  String get authorizationHeaderValue => "Bearer $token";
  bool get isExpired => false;

  AuthorizationToken();

  factory AuthorizationToken.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationTokenFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorizationTokenToJson(this);
}
