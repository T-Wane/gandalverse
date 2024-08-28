
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gandalverse/core/modeles/serializers/serializers.dart';


part 'evenement.g.dart';

abstract class EvenementModel
    implements Built<EvenementModel, EvenementModelBuilder> {
  String? get titre;
  String? get image;
  String? get description;
  String? get id; 

  EvenementModel._();
  factory EvenementModel([void Function(EvenementModelBuilder) updates]) =
      _$EvenementModel;

  static Serializer<EvenementModel> get serializer =>
      _$evenementModelSerializer;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(EvenementModel.serializer, this)
        as Map<String, dynamic>;
  }

  static EvenementModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(EvenementModel.serializer, json)!;
  }
}
