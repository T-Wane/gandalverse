import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:gandalverse/core/modeles/serializers/serializers.dart';

part 'carte.g.dart';

// Enum pour les types de contrainte
enum ContrainteType {
  niveauRequis,
  carteRequise,
  niveauCarteRequise,
  profitRequis,
  codeRequis,
  amisRequis,
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
  Object get valeurContrainte;

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
        if (niveauUtilisateur < (valeurContrainte as int)) {
          return 'Niveau requis: ${valeurContrainte as int}';
        }
        break;
      case ContrainteType.carteRequise:
        if (!cartesPossedees.contains(valeurContrainte as String)) {
          return 'Carte requise: ${valeurContrainte as String}';
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
        if (profitParHeure < (valeurContrainte as double)) {
          return 'Profit requis: ${valeurContrainte as double}';
        }
        break;
      case ContrainteType.codeRequis:
        if (codeSaisi != valeurContrainte as String) {
          return 'Code requis: ${valeurContrainte as String}';
        }
        break;
      case ContrainteType.amisRequis:
        if (nombreAmis < (valeurContrainte as int)) {
          return 'Nombre d\'amis requis: ${valeurContrainte as int}';
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
        return cartesPossedees.contains(valeurContrainte as String);
      case ContrainteType.niveauCarteRequise:
        final carteRequiseId = valeurContrainte as String;
        return niveauxCartesPossedees.containsKey(carteRequiseId) &&
            niveauxCartesPossedees[carteRequiseId]! >=
                1; // Ajustez selon les besoins
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
