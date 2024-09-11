import 'dart:async';
import 'dart:developer';
import 'package:built_collection/built_collection.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:injectable/injectable.dart';
import 'QGService.dart';

@lazySingleton
class PartenaireService extends QGService<CarteModel> {
  @override
  String get assetPath => 'assets/json/partenaireData.json';
  @override
  String get storageKey => 'partenaires_key';

  final _partenaireController = StreamController<List<CarteModel>>.broadcast();
  UserProvider _userProvider;

  PartenaireService(this._userProvider) {
    synchronizeCards();
  }

  Stream<List<CarteModel>> get partenaireStream => _partenaireController.stream;

  Future<void> synchronizeCards() async {
    final purchasedCards = await _userProvider.loadUserPurchasedCards();
    await updateBaseCardsWithPurchased(purchasedCards);

    // Notify subscribers about the updated cards
    final data = await loadBaseCards();
    _partenaireController.add(data);
  }

  Future<List<CarteModel>> loadBaseCards() async {
    final data = await loadItems();
    return data;
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

    await saveItems2(baseCards);
  }

  Future<void> loadInitialData() async {
    final partenaires = await loadItems();
    _partenaireController.add(partenaires);
  }

  @override
  CarteModel fromJson(Map<String, dynamic> json) => CarteModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(CarteModel item) => item.toJson();

  @override
  String getName(CarteModel item) => item.nom;

  @override
  String? getCarteId(CarteModel item) => item.carteId;

   @override
  bool isSameLink(CarteModel carteModel, CarteModel carteJson) {
    return carteModel.carteId == carteJson.carteId;
  }
}
