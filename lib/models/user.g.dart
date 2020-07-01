// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return LoginModel(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) {
  return RegisterModel(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

ResetPasswordModel _$ResetPasswordModelFromJson(Map<String, dynamic> json) {
  return ResetPasswordModel(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$ResetPasswordModelToJson(ResetPasswordModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
