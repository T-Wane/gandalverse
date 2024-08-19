import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:gandalverse/core/modeles/serializers/serializers.dart';

part 'carte.g.dart';

abstract class CarteModel implements Built<CarteModel, CarteModelBuilder> {
  @BuiltValueField(wireName: 'id')
  String? get carteId;

  String get nom;
  String get description;

  BuiltList<String>? get competences;
  String get image;
  double get prix;

  @BuiltValueField(wireName: 'taux_augmentation')
  double get tauxAugmentation;

  int get niveau;

  @BuiltValueField(wireName: 'est_achete')
  bool get estAchete;

  double get force;

  @BuiltValueField(wireName: 'taux_augmentation_force')
  double get tauxAugmentationForce;

  CarteModel._();
  factory CarteModel([void Function(CarteModelBuilder) updates]) = _$CarteModel;

  static Serializer<CarteModel> get serializer => _$carteModelSerializer;

  //--------------------------------------------------------//

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CarteModel.serializer, this)
        as Map<String, dynamic>;
  }

  static CarteModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CarteModel.serializer, json)!;
  }

  //--------------------------------------------------------//
  double increase(double value, double taux) {
    return (niveau > 0 ? (taux * niveau * value) : value);
  }

  String get getPrix => increase(prix, tauxAugmentation).toStringAsFixed(1);
  double get getPrix_inDouble => increase(prix, tauxAugmentation);

  String get getForce =>
      increase(force, tauxAugmentationForce).toStringAsFixed(1);

  String get prixFormate {
    final adjustedPrix = prix * (niveau > 0 ? (tauxAugmentation * niveau) : 1);
    if (adjustedPrix >= 1000000) {
      return '${(adjustedPrix / 1000000).toStringAsFixed(1)}M';
    } else if (adjustedPrix >= 1000) {
      return '${(adjustedPrix / 1000).toStringAsFixed(1)}K';
    } else {
      return adjustedPrix.toStringAsFixed(1);
    }
  }

  String get forceFormate {
    if (force >= 1000000) {
      return '${(force / 1000000).toStringAsFixed(1)}M';
    } else if (force >= 1000) {
      return '${(force / 1000).toStringAsFixed(1)}K';
    } else {
      return force.toStringAsFixed(0);
    }
  }
}
