import 'dart:async';
import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:injectable/injectable.dart';

import '../../modeles/carte_model/carte.dart';
import 'QGService.dart';

@lazySingleton
class EquipeService extends QGService<CarteModel> {
  UserProvider _userProvider;

  EquipeService(this._userProvider) {
    synchronizeCards();
  }

  List<Map<String, dynamic>>? purchasedCards;

  @override
  String get assetPath => 'assets/json/equipeData.json';
  @override
  String get storageKey => 'equipes_key';

  final _equipeController = StreamController<List<CarteModel>>.broadcast();

  Stream<List<CarteModel>> get equipeStream => _equipeController.stream;

  Future<void> synchronizeCards() async {
    purchasedCards = await _userProvider.loadUserPurchasedCards();
    await updateBaseCardsWithPurchased(purchasedCards??[]);

    // Notify subscribers about the updated cards
    final equipes = await loadBaseCards();
    _equipeController.add(equipes);
  }

  Future<List<CarteModel>> loadBaseCards() async {
    final equipes = await loadItems();
    return equipes;
  }

  Future<void> updateBaseCardsWithPurchased(
      List<Map<String, dynamic>> purchasedCards) async {
    final baseCards = await loadBaseCards();

    log("############ purchasedCards ${purchasedCards.length}");

    for (var purchasedCard in purchasedCards) {
      final index =
          baseCards.indexWhere((card) => card.carteId == purchasedCard['id']);
      if (index != -1) {
        CarteModel _card = baseCards[index];
        baseCards[index] = CarteModel((b) => b
          ..carteId = _card.carteId
          ..nom = _card.nom
          ..description = _card.description
          ..competences =
              BuiltList<String>.from(_card.competences?.toList() ?? [])
                  .toBuilder()
          ..image = _card.image
          ..prix = _card.prix
          ..tauxAugmentation = _card.tauxAugmentation
          ..niveau = purchasedCard['niveau']+1
          ..estAchete = purchasedCard['est_achete']
          ..force = _card.force
          ..tauxAugmentationForce = _card.tauxAugmentationForce
          ..contrainteType = _card.contrainteType
          ..valeurContrainte = _card.valeurContrainte);
      }
    }
    log("############ after merge with purchasedCards baseCards :${baseCards.map((e) => e.toJson())}");
    await saveItems2(baseCards);
  }

  Future<void> loadInitialData() async {
    if(purchasedCards==null) await synchronizeCards();
    final equipes = await loadItems();
    // log("####_loadInitialData ");
    // log("####_loadInitialData ${equipes.length}");
    _equipeController.add(equipes);
  }

// Comparer deux produits par leur ID
  @override
  bool isSameLink(CarteModel carteModel, CarteModel carteJson) {
    return carteModel.carteId == carteJson.carteId;
  }

  @override
  CarteModel fromJson(Map<String, dynamic> json) => CarteModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(CarteModel item) => item.toJson();

  @override
  String getName(CarteModel item) => item.nom;

  @override
  String? getCarteId(CarteModel item) => item.carteId;
}
