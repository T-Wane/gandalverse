import 'package:gandalverse/core/modeles/carte.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
 
class EquipeService {
  Future<List<Carte>> loadEquipe() async {
    final jsonString = await rootBundle.loadString('assets/json/equipeData.json');
    final jsonResponse = json.decode(jsonString) as List<dynamic>;
    return jsonResponse.map((json) => Carte.fromJson(json)).toList();
  }

  Future<void> updateEquipe(List<Carte> equipeList) async {
    // Exemple de mise à jour
  }

  Future<void> saveEquipe(List<Carte> equipeList) async {
    final jsonString = json.encode(equipeList.map((equipe) => equipe.toJson()).toList());
    // Code pour écrire dans le fichier
  }

  Future<Carte?> findEquipeByName(String name) async {
    final equipeList = await loadEquipe();
    return equipeList.firstWhere((equipe) => equipe.nom == name, orElse: () => null);
  }
}
