import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:gandalverse/core/modeles/carte.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

/*class EquipeService {
  Future<List<Carte>> loadEquipe() async {
    final jsonString = await rootBundle.loadString('json/equipeData.json');
    final jsonResponse = json.decode(jsonString) as List<dynamic>;
    return jsonResponse.map((json) => Carte.fromJson(json)).toList();
  }

  Future<void> saveEquipe(List<Carte> equipeList) async {
    final file = File('json/equipeData.json');
    final jsonData = equipeList.map((equipe) => equipe.toJson()).toList();

    log("file existe ${file.existsSync()}");
    //await file.writeAsString(json.encode(jsonData), flush: true);
  }

  Future<void> updateEquipe(String nom, Carte updatedEquipe) async {
    final equipes = await loadEquipe();
    final index = equipes.indexWhere((equipe) => equipe.nom == nom);
    if (index != -1) {
      equipes[index] = updatedEquipe;
      await saveEquipe(equipes);
    }
  }

}
*/
/*


  Future<Carte?> findEquipeByName(String name) async {
    final equipeList = await loadEquipe();
    return equipeList.firstWhere((equipe) => equipe.nom == name);
  }*/

class EquipeService {
  final String assetPath = 'json/equipeData.json';
  final String storageKey = 'equipes';

  final _equipeController = StreamController<List<Carte>>.broadcast();
  final _loadingController = StreamController<bool>.broadcast();

  EquipeService() {
    _loadInitialData();
  }

  Stream<List<Carte>> get equipeStream => _equipeController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  Future<void> _loadInitialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(storageKey);

    if (jsonString == null) {
      jsonString = await rootBundle.loadString(assetPath);
      prefs.setString(storageKey, jsonString);
    }

    final List<dynamic> jsonData = json.decode(jsonString);
    final equipes = jsonData.map((data) => Carte.fromJson(data)).toList();
    _equipeController.add(equipes);
  }

  Future<List<Carte>> loadEquipes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(storageKey);

    if (jsonString == null) {
      jsonString = await rootBundle.loadString(assetPath);
      prefs.setString(storageKey, jsonString);
    }

    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => Carte.fromJson(data)).toList();
  }

  Future<void> saveEquipes(List<Carte> equipes) async {
    _loadingController.add(true);
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonData = equipes.map((equipe) => equipe.toJson()).toList();
      prefs.setString(storageKey, json.encode(jsonData));
      await _loadInitialData();
      _loadingController.add(false);
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final jsonData = equipes.map((equipe) => equipe.toJson()).toList();
    // prefs.setString(storageKey, json.encode(jsonData));
    // await _loadInitialData();
    // _loadingController.add(false);
  }

  Future<void> updateEquipe(String nom, Carte updatedEquipe) async {
    final equipes = await loadEquipes();
    final index = equipes.indexWhere((equipe) => equipe.nom == nom);
    if (index != -1) {
      equipes[index] = updatedEquipe;
      await saveEquipes(equipes);
    }
  }
}
