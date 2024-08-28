import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
import 'package:gandalverse/core/modeles/explorer/evenement/evenement.dart';
import 'package:gandalverse/core/services/explorer_service/explorer_service_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

///See the detailed [documentation here - explorer.md](explorer.md)
///
@singleton
class ExplorerService with ChangeNotifier {
  String cateorieJsonPath = "assets/json/categorieData.json";
  String cateoriesSaveKey = "categoriesDataKey";

  String eventsJsonPath = "assets/json/eventsData.json";
  String eventsSaveKey = "eventsDataKey";

  List<CategorieModel> categoriesData = [];
  List<EvenementModel> evenementsData = [];

  ExplorerService() {
    loadCategories();
    loadEvents();
  }

  void loadCategories() async {
    final data = await loadItems((json) => CategorieModel.fromJson(json),
        cateoriesSaveKey, cateorieJsonPath);
    categoriesData = List<CategorieModel>.from(data);
    notifyListeners();
  }

  void loadEvents() async {
    final data = await loadItems(
        (json) => EvenementModel.fromJson(json), eventsSaveKey, eventsJsonPath);
    evenementsData = List<EvenementModel>.from(data);
    notifyListeners();
  }

  Future<List<CategorieModel>> getCategories() async {
    if (categoriesData.isNotEmpty) return categoriesData;
    final data = await loadItems((json) => CategorieModel.fromJson(json),
        cateoriesSaveKey, cateorieJsonPath);
    return List<CategorieModel>.from(data);
  }

  Future<Map<CategorieType, List<CategorieModel>>> categoriserParType() async {
    List<CategorieModel> categories = await getCategories();
    Map<CategorieType, List<CategorieModel>> categoriesParType = {};

    for (var categorie in categories) {
      print("${categorie.categorieType?.name ?? '------------'}");
      if (!categoriesParType.containsKey(categorie.categorieType)) {
        if (categorie.categorieType != null) {
          categoriesParType[categorie.categorieType!] = [];
        }
      }
      categoriesParType[categorie.categorieType]?.add(categorie);
    }
    return categoriesParType;
  }

  //############### [ EVENTS ] #############################//

  Future<List<EvenementModel>> getEvents() async {
    if (evenementsData.isNotEmpty) return evenementsData;
    final data = await loadItems(
        (json) => EvenementModel.fromJson(json), eventsSaveKey, eventsJsonPath);
    return List<EvenementModel>.from(data);
  }
}
