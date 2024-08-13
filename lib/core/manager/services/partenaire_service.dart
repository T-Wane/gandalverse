import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:gandalverse/core/modeles/carte.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gandalverse/core/manager/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
/*


  Future<Carte?> findPartenaireByName(String name) async {
    final partenaireList = await loadPartenaire();
    return partenaireList.firstWhere((partenaire) => partenaire.nom == name);
  }*/

class PartenaireService implements QGService {
  final String assetPath = 'assets/json/partenaireData.json';
  final String storageKey = 'partenaires6';

  final _partenaireController = StreamController<List<Carte>>.broadcast();
  final _loadingController = StreamController<bool>.broadcast();

  PartenaireService() {
    _loadInitialData();
  }

  Stream<List<Carte>> get partenaireStream => _partenaireController.stream;
  
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
    final partenaires = jsonData.map((data) => Carte.fromJson(data)).toList();
    _partenaireController.add(partenaires);
  }

  Future<List<Carte>> loadPartenaires() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(storageKey);

    if (jsonString == null) {
      jsonString = await rootBundle.loadString(assetPath);
      prefs.setString(storageKey, jsonString);
    }

    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => Carte.fromJson(data)).toList();
  }

  Future<void> savePartenaires(List<Carte> partenaires) async {
    _loadingController.add(true);
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonData = partenaires.map((partenaire) => partenaire.toJson()).toList();
      prefs.setString(storageKey, json.encode(jsonData));
      await _loadInitialData();
      _loadingController.add(false);
    }); 
  }

  @override
  Future<void> updateCarte(String nom, Carte updatedPartenaire) async {
    final partenaires = await loadPartenaires();
    final index = partenaires.indexWhere((partenaire) => partenaire.nom == nom);
    if (index != -1) {
      partenaires[index] = updatedPartenaire;
      await savePartenaires(partenaires);
    }
  }
}
