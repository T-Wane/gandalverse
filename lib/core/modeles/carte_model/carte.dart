import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:gandalverse/core/modeles/serializers/serializers.dart';

part 'carte.g.dart';

// Définir une énumération ou une classe pour ContrainteType
class ContrainteType extends EnumClass {
  static const ContrainteType niveauRequis = _$niveauRequis;
  static const ContrainteType carteRequise = _$carteRequise;
  static const ContrainteType niveauCarteRequise = _$niveauCarteRequise;
  static const ContrainteType profitRequis = _$profitRequis;
  static const ContrainteType codeRequis = _$codeRequis;
  static const ContrainteType amisRequis = _$amisRequis;

  const ContrainteType._(String name) : super(name);

  static BuiltSet<ContrainteType> get values => _$values;
  static ContrainteType valueOf(String name) => _$valueOf(name);

  static Serializer<ContrainteType> get serializer =>
      _$contrainteTypeSerializer;
}

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

  // Nouveaux champs pour les contraintes de déblocage
  @BuiltValueField(wireName: 'contrainte_type')
  ContrainteType? get contrainteType;

  @BuiltValueField(wireName: 'valeur_contrainte')
  String? get valeurContrainte;

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
  //--------------------------------------------------------//

  /// Calcule l'augmentation basée sur le niveau et le taux
  double _calculateAugmentation(double baseValue, double taux) {
    return niveau > 0 ? baseValue * (1 + taux * niveau) : baseValue;
  }

  /// Prix réel de la carte après augmentation
  double get prixReel => _calculateAugmentation(prix, tauxAugmentation);

  /// Force réelle après augmentation
  double get forceReelle =>
      _calculateAugmentation(force, tauxAugmentationForce);

  //--------------------------------------------------------//
  // Nouveaux getters pour récupérer les valeurs sous forme de String

  /// Prix réel formaté en `String`
  String get getPrixReel => prixReel.toStringAsFixed(1);

  /// Force réelle formatée en `String`
  String get getForceReel => forceReelle.toStringAsFixed(1);

  //--------------------------------------------------------//

  /// Prix formaté en K ou M si nécessaire
  String get prixFormate {
    final adjustedPrix = prixReel;
    if (adjustedPrix >= 1000000) {
      return '${(adjustedPrix / 1000000).toStringAsFixed(1)}M';
    } else if (adjustedPrix >= 1000) {
      return '${(adjustedPrix / 1000).toStringAsFixed(1)}K';
    } else {
      return adjustedPrix.toStringAsFixed(1);
    }
  }

  /// Force formatée en K ou M si nécessaire
  String get forceFormate {
    final adjustedForce = forceReelle;
    if (adjustedForce >= 1000000) {
      return '${(adjustedForce / 1000000).toStringAsFixed(1)}M';
    } else if (adjustedForce >= 1000) {
      return '${(adjustedForce / 1000).toStringAsFixed(1)}K';
    } else {
      return adjustedForce.toStringAsFixed(0);
    }
  }

  //--------------------------------------------------------//

  //--------------------------------------------------------//
  //--------------------------------------------------------//

  String? contrainteVerrouillage({
    required int niveauUtilisateur,
    required BuiltList<String> cartesPossedees,
    required BuiltMap<String, int> niveauxCartesPossedees,
    required double profitParHeure,
    required String codeSaisi,
    required int nombreAmis,
  }) {
    switch (contrainteType) {
      case ContrainteType.niveauRequis:
        if (niveauUtilisateur < int.parse(valeurContrainte ?? '0')) {
          return 'Niv.$valeurContrainte requis';
        }
        break;
      case ContrainteType.carteRequise:
        String? carteName = valeurContrainte!.split(',')[0];
        String? carteId = valeurContrainte!.split(',')[1];
        String? carteLevel = valeurContrainte!.split(',')[2];
        if (!cartesPossedees.contains(carteId)) {
          return " $carteName Niv$carteLevel";
        }
        break;
      case ContrainteType.niveauCarteRequise:
        final carteRequiseId = valeurContrainte as String;
        if (!niveauxCartesPossedees.containsKey(carteRequiseId) ||
            niveauxCartesPossedees[carteRequiseId]! < 1) {
          // Vous pouvez ajuster le niveau requis ici
          return 'Carte requise à niveau: $carteRequiseId';
        }
        break;
      case ContrainteType.profitRequis:
        if (profitParHeure < double.parse(valeurContrainte ?? '0')) {
          return '$valeurContrainte Grade requis';
        }
        break;
      case ContrainteType.codeRequis:
        if (codeSaisi != valeurContrainte as String) {
          //: ${valeurContrainte as String}
          return 'Code Requis';
        }
        break;
      case ContrainteType.amisRequis:
        if (nombreAmis < int.parse(valeurContrainte ?? '0')) {
          return 'Inviter $valeurContrainte amis';
        }
        break;
      default:
        return null;
    }
    return null;
  }

  //--------------------------------------------------------//

  bool canUnlockCarte({
    required int niveauUtilisateur,
    required BuiltList<String> cartesPossedees,
    required BuiltMap<String, int> niveauxCartesPossedees,
    required double profitParHeure,
    required String codeSaisi,
    required int nombreAmis,
  }) {
    switch (contrainteType) {
      case ContrainteType.niveauRequis:
        return niveauUtilisateur >= (valeurContrainte as int);
      case ContrainteType.carteRequise:
        String? carteName = valeurContrainte!.split(',')[0];
        String? carteId = valeurContrainte!.split(',')[1];
        String? carteLevel = valeurContrainte!.split(',')[2];
        return cartesPossedees.contains(carteId as String) &&
            niveauxCartesPossedees[carteId]! >=
                (int.parse(carteLevel ?? '0') ?? 0);
      case ContrainteType.niveauCarteRequise:
        final carteRequiseId = valeurContrainte as String;
        return niveauxCartesPossedees.containsKey(carteRequiseId) &&
            niveauxCartesPossedees[carteRequiseId]! >= 1;
      case ContrainteType.profitRequis:
        return profitParHeure >= (valeurContrainte as double);
      case ContrainteType.codeRequis:
        return codeSaisi == (valeurContrainte as String);
      case ContrainteType.amisRequis:
        return nombreAmis >= (valeurContrainte as int);
      default:
        return false;
    }
  }
}


























//################### OLD VERSION ###########################
// abstract class CarteModel implements Built<CarteModel, CarteModelBuilder> {
//   @BuiltValueField(wireName: 'id')
//   String? get carteId;
//   String get nom;
//   String get description;

//   BuiltList<String>? get competences;
//   String get image;
//   double get prix;

//   @BuiltValueField(wireName: 'taux_augmentation')
//   double get tauxAugmentation;

//   int get niveau;

//   @BuiltValueField(wireName: 'est_achete')
//   bool get estAchete;

//   double get force;

//   @BuiltValueField(wireName: 'taux_augmentation_force')
//   double get tauxAugmentationForce;

//   CarteModel._();
//   factory CarteModel([void Function(CarteModelBuilder) updates]) = _$CarteModel;

//   static Serializer<CarteModel> get serializer => _$carteModelSerializer;

//   //--------------------------------------------------------//

//   Map<String, dynamic> toJson() {
//     return serializers.serializeWith(CarteModel.serializer, this)
//         as Map<String, dynamic>;
//   }

//   static CarteModel fromJson(Map<String, dynamic> json) {
//     return serializers.deserializeWith(CarteModel.serializer, json)!;
//   }

//   //--------------------------------------------------------//
//   double increase(double value, double taux) {
//     return (niveau > 0 ? (taux * niveau * value) : value);
//   }

//   String get getPrix => increase(prix, tauxAugmentation).toStringAsFixed(1);
//   double get getPrix_inDouble => increase(prix, tauxAugmentation);

//   String get getForce =>
//       increase(force, tauxAugmentationForce).toStringAsFixed(1);

//   String get prixFormate {
//     final adjustedPrix = prix * (niveau > 0 ? (tauxAugmentation * niveau) : 1);
//     if (adjustedPrix >= 1000000) {
//       return '${(adjustedPrix / 1000000).toStringAsFixed(1)}M';
//     } else if (adjustedPrix >= 1000) {
//       return '${(adjustedPrix / 1000).toStringAsFixed(1)}K';
//     } else {
//       return adjustedPrix.toStringAsFixed(1);
//     }
//   }

//   String get forceFormate {
//     if (force >= 1000000) {
//       return '${(force / 1000000).toStringAsFixed(1)}M';
//     } else if (force >= 1000) {
//       return '${(force / 1000).toStringAsFixed(1)}K';
//     } else {
//       return force.toStringAsFixed(0);
//     }
//   }
// }
