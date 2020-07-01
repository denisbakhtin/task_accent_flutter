import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String password;

  User({
    this.email,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class LoginModel {
  final String email;
  final String password;

  LoginModel({
    this.email,
    this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class RegisterModel {
  final String email;
  final String password;

  RegisterModel({
    this.email,
    this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}

@JsonSerializable()
class ResetPasswordModel {
  final String email;
  final String password;

  ResetPasswordModel({
    this.email,
    this.password,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);
}
