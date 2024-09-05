import 'package:built_collection/built_collection.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';

extension CarteServiceExtension on QGService {
  bool canUnlockCarte(
    CarteModel carte, {
    required int niveauUtilisateur,
    required BuiltList<String> cartesPossedees,
    required BuiltMap<String, int> niveauxCartesPossedees,
    required double profitParHeure,
    required String codeSaisi,
    required int nombreAmis,
  }) {
    return carte.canUnlockCarte(
      niveauUtilisateur: niveauUtilisateur,
      cartesPossedees: cartesPossedees,
      niveauxCartesPossedees: niveauxCartesPossedees,
      profitParHeure: profitParHeure,
      codeSaisi: codeSaisi,
      nombreAmis: nombreAmis,
    );
  }

  String? getContrainteVerrouillage(
    CarteModel carte, {
    required int niveauUtilisateur,
    required BuiltList<String> cartesPossedees,
    required BuiltMap<String, int> niveauxCartesPossedees,
    required double profitParHeure,
    required String codeSaisi,
    required int nombreAmis,
  }) {
    return carte.contrainteVerrouillage(
      niveauUtilisateur: niveauUtilisateur,
      cartesPossedees: cartesPossedees,
      niveauxCartesPossedees: niveauxCartesPossedees,
      profitParHeure: profitParHeure,
      codeSaisi: codeSaisi,
      nombreAmis: nombreAmis,
    );
  }
}
