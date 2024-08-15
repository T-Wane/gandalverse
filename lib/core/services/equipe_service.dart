import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:gandalverse/core/modeles/carte.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'service.dart';

/*


  Future<Carte?> findEquipeByName(String name) async {
    final equipeList = await loadEquipe();
    return equipeList.firstWhere((equipe) => equipe.nom == name);
  }*/

class EquipeService implements QGService {
  final String assetPath = 'assets/json/equipeData.json';
  final String storageKey = 'equipes2';

  final _equipeController = StreamController<List<Carte>>.broadcast();
  final _loadingController = StreamController<bool>.broadcast();

  EquipeService() {
    _loadInitialData();
  }

  Stream<List<Carte>> get equipeStream => _equipeController.stream;

  @override
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

  @override
  Future<void> updateCarte(String nom, Carte updatedEquipe) async {
    final equipes = await loadEquipes();
    final index = equipes.indexWhere((equipe) => equipe.nom == nom);
    if (index != -1) {
      equipes[index] = updatedEquipe;
      await saveEquipes(equipes);
    }
  }
}
