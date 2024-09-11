import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart'; 
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;

@singleton
class SocialLinkService with ChangeNotifier {
  String socialLinksJsonPath = "assets/json/socialLinksData.json";
  String socialLinksSaveKey = "socialLinksDataKey4";

  List<SocialLinkModel> socialLinksData = [];

  SocialLinkService() {
    loadSocialLinks();
  }

  void loadSocialLinks() async {
    final data = await loadAndMergeItems();
    socialLinksData = List<SocialLinkModel>.from(data);
    notifyListeners();
  }

  Future<List<SocialLinkModel>> getSocialLinks() async {
    //   if (socialLinksData.isNotEmpty) return socialLinksData;
    final data = await loadAndMergeItems();
    notifyListeners();

    print("getSocialLinks => data ${data.length}");
    return List<SocialLinkModel>.from(data);
  }

  SocialLinkModel fromJson(Map<String, dynamic> json) =>
      SocialLinkModel.fromJson(json);

  Map<String, dynamic> toJson(SocialLinkModel item) => item.toJson();

  // Comparer deux produits par leur ID
  bool isSameLink(SocialLinkModel locallink, SocialLinkModel jsonlink) {
    return locallink.id == jsonlink.id;
  }

  /// Update a social link in the list, and save it to the user's preferences.
  ///
  /// If [isSubscribed] or [reward] are not provided, the existing values will be used.
  ///
  /// Emits a notification to listeners when the update is complete.
  Future<void> updateSocialLink(String id,
      {bool? isSubscribed, double? reward}) async {
    final index = socialLinksData.indexWhere((link) => link.id == id);
    if (index == -1) return;

    final updatedLink = socialLinksData[index].rebuild((b) => b
      ..isSubscribed = isSubscribed ?? socialLinksData[index].isSubscribed
      ..reward = reward ?? socialLinksData[index].reward);

    socialLinksData[index] = updatedLink;

    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        json.encode(socialLinksData.map((link) => link.toJson()).toList());
    await prefs.setString(socialLinksSaveKey, jsonString);

    notifyListeners();
  }

  // Méthode pour ouvrir un lien
  Future<void> openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Fonction pour charger, comparer et fusionner les données JSON avec les données locales
  Future<List<SocialLinkModel>> loadAndMergeItems() async {
    try {
      // 1. Récupérer les SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // 2. Charger les données locales de l'utilisateur
      String? localJsonString = prefs.getString(socialLinksSaveKey);
      List<SocialLinkModel> localData = [];

      if (localJsonString != null) {
        final List<dynamic> localJsonData = json.decode(localJsonString);
        localData = localJsonData
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      }
      //print("localData => $localData ${localData.length}");
      // 3. Charger les données depuis le fichier JSON (données administratives)
      String jsonString = await rootBundle.loadString(socialLinksJsonPath);
      //print("jsonAdminData jsonString => $jsonString");
      final List<dynamic> jsonData = json.decode(jsonString);
      //  print("jsonAdminData  List<dynamic> jsonData => $jsonData");
      List<SocialLinkModel> jsonAdminData = jsonData
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();

      //print("jsonAdminData => $jsonAdminData \n ${jsonAdminData.length}");
      // 4. Fusionner les données locales avec les données JSON
      // On fusionne en remplaçant les données locales si elles existent, sinon en les ajoutant
      List<SocialLinkModel> mergedData = localData;

      for (SocialLinkModel jsonItem in jsonAdminData) {
        // Vérifier si l'élément du JSON existe déjà dans les données locales
        SocialLinkModel? localItem;
// Parcourir la liste `localData` pour trouver un élément qui correspond
        for (SocialLinkModel item in localData) {
          if (isSameLink(item, jsonItem)) {
            localItem = item;
            break; // On sort de la boucle dès qu'on trouve une correspondance
          }
        }

        if (localItem == null) {
          // Si l'élément JSON n'existe pas dans les données locales, on l'ajoute
          mergedData.add(jsonItem);
        } else {
          // Si l'élément JSON existe dans les données locales, on garde l'élément local (on pourrait le mettre à jour selon certaines conditions)
          // mergedData.add(localItem); // L'élément local reste inchangé dans ce cas
          print("L'élément local reste inchangé dans ce cas");
        }
      }

      // 5. Sauvegarder les données fusionnées localement
      List<Map<String, dynamic>> jsonSocialLinkModeloSave =
          mergedData.map((item) => toJson(item)).toList();
      await prefs.setString(
          socialLinksSaveKey, json.encode(jsonSocialLinkModeloSave));

      return mergedData;
    } catch (e, stacktrace) {
      // 6. Gestion des erreurs et affichage du stacktrace
      print("######[ ERROR in loadAndMergeItems: $e ]######");
      log("######[ ERROR in loadAndMergeItems: $e ]######");
      log("######[ SSocialLinkModelACKSocialLinkModelRACE: $stacktrace ]######");
      return []; // Retourner une liste vide en cas d'erreur
    }
  }

  Future<List<SocialLinkModel>> loadItems(
      SocialLinkModel Function(Map<String, dynamic>) fromJson,
      String storageKey,
      String assetPath) async {
    List<SocialLinkModel> data = await loadAndMergeItems();

    return data;
  }
}
