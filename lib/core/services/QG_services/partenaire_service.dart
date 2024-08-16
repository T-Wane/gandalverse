import 'dart:async';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:injectable/injectable.dart';
import 'QGService.dart';


@lazySingleton
class PartenaireService extends QGService<CarteModel> {
  @override
  String get assetPath => 'assets/json/partenaireData.json';
  @override
  String get storageKey => 'partenaires6';

  final _partenaireController = StreamController<List<CarteModel>>.broadcast();

  PartenaireService() {
    _loadInitialData();
  }

  Stream<List<CarteModel>> get partenaireStream => _partenaireController.stream;

  Future<void> _loadInitialData() async {
    final partenaires = await loadItems();
    _partenaireController.add(partenaires);
  }

  @override
  CarteModel fromJson(Map<String, dynamic> json) => CarteModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(CarteModel item) => item.toJson();

  @override
  String getName(CarteModel item) => item.nom;
}
