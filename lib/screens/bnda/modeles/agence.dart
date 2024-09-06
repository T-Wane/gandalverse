import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'agence.g.dart';

@JsonSerializable()
class Agence {
  int? id;
  String? image;
  String? designation;
  String? information;
  String? adresse;
  String? email;
  String? phone;
  String? fax;
  double? long;
  double? lat;

  Agence(
      {this.id,
      this.image,
      this.information,
      this.designation,
      this.adresse,
      this.email,
      this.phone,
      this.fax,
      this.long,
      this.lat});

  Map<String, dynamic> toJson() => _$AgenceToJson(this);
  String toJsonEncode() => jsonEncode(_$AgenceToJson(this));
}
