// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createUser_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserFields _$CreateUserFieldsFromJson(Map<String, dynamic> json) =>
    CreateUserFields(
      telegramId: (json['telegramId'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$CreateUserFieldsToJson(CreateUserFields instance) =>
    <String, dynamic>{
      'telegramId': instance.telegramId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'photoUrl': instance.photoUrl,
    };
