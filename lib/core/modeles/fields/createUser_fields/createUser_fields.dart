import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'createUser_fields.g.dart';

@JsonSerializable()
class CreateUserFields {
  int? telegramId;
  String? firstName;
  String? lastName;
  String? username;
  String? photoUrl;

  CreateUserFields(
      {this.telegramId,
      this.firstName,
      this.lastName,
      this.username,
      this.photoUrl});

  Map<String, dynamic> toJson() => _$CreateUserFieldsToJson(this);
  String toJsonEncode() => jsonEncode(_$CreateUserFieldsToJson(this));
}
