// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agence _$AgenceFromJson(Map<String, dynamic> json) => Agence(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
      information: json['information'] as String?,
      designation: json['designation'] as String?,
      adresse: json['adresse'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      fax: json['fax'] as String?,
      long: (json['long'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AgenceToJson(Agence instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'designation': instance.designation,
      'information': instance.information,
      'adresse': instance.adresse,
      'email': instance.email,
      'phone': instance.phone,
      'fax': instance.fax,
      'long': instance.long,
      'lat': instance.lat,
    };
