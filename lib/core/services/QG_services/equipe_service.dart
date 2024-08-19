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

  @override
  String get assetPath => 'assets/json/equipeData.json';
  @override
  String get storageKey => 'equipes5';

  final _equipeController = StreamController<List<CarteModel>>.broadcast();

  Stream<List<CarteModel>> get equipeStream => _equipeController.stream;

  Future<void> synchronizeCards() async {
    final purchasedCards = await _userProvider.loadUserPurchasedCards();
    await updateBaseCardsWithPurchased(purchasedCards);

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
          ..niveau = purchasedCard['niveau']
          ..estAchete = purchasedCard['est_achete']
          ..force = _card.force
          ..tauxAugmentationForce = _card.tauxAugmentationForce);
      }
    }

    await saveItems2(baseCards);
  }

  Future<void> loadInitialData() async {
    final equipes = await loadItems();
    // log("####_loadInitialData ");
    // log("####_loadInitialData ${equipes.length}");
    _equipeController.add(equipes);
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
