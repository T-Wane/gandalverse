import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../modeles/carte_model/carte.dart';
import 'QGService.dart';

@lazySingleton
class EquipeService extends QGService<CarteModel> {
  @override
  String get assetPath => 'assets/json/equipeData.json';
  @override
  String get storageKey => 'equipes5';

  final _equipeController = StreamController<List<CarteModel>>.broadcast();

  EquipeService() {
    loadInitialData();
  }

  Stream<List<CarteModel>> get equipeStream => _equipeController.stream;

  Future<void> loadInitialData() async {
    final equipes = await loadItems();
    log("####_loadInitialData ");
    log("####_loadInitialData ${equipes.length}");
   // _equipeController.add(equipes);
  }

  @override
  CarteModel fromJson(Map<String, dynamic> json) => CarteModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(CarteModel item) => item.toJson();

  @override
  String getName(CarteModel item) => item.nom;
}
