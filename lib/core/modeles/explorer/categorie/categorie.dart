import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gandalverse/core/modeles/serializers/serializers.dart';
import 'package:gandalverse/themes/images/appImages.dart';

part 'categorie.g.dart';

class CategorieType extends EnumClass {
  static const CategorieType top20 = _$top20;
  static const CategorieType resto = _$resto;
  static const CategorieType banques = _$banques;
  static const CategorieType guichets = _$guichets;
  static const CategorieType tourisme = _$tourisme;
  static const CategorieType hotels = _$hotels;
  static const CategorieType shopping = _$shopping;

  const CategorieType._(String name) : super(name);

  static BuiltSet<CategorieType> get values => _$values;
  static CategorieType valueOf(String name) => _$valueOf(name);
  static Serializer<CategorieType> get serializer => _$categorieTypeSerializer;

  String get imageAsset {
    switch (this) {
      case CategorieType.top20:
        return Images.badge;
      case CategorieType.resto:
        return Images.restaurant;
      case CategorieType.banques:
        return Images.bank;
      case CategorieType.guichets:
        return Images.tickets;
      case CategorieType.tourisme:
        return Images.photo_camera;
      case CategorieType.hotels:
        return Images.luggage_cart;
      case CategorieType.shopping:
        return Images.shopping_bag;
      default:
        return Images.badge; // Image par défaut si le type n'est pas reconnu
    }
  }
}

abstract class CategorieModel
    implements Built<CategorieModel, CategorieModelBuilder> {
  String? get titre;
  String? get image;
  String? get description;
  String? get id;
  CategorieType? get categorieType;

  CategorieModel._();
  factory CategorieModel([void Function(CategorieModelBuilder) updates]) =
      _$CategorieModel;

  static Serializer<CategorieModel> get serializer =>
      _$categorieModelSerializer;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CategorieModel.serializer, this)
        as Map<String, dynamic>;
  }

  static CategorieModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CategorieModel.serializer, json)!;
  }
}
