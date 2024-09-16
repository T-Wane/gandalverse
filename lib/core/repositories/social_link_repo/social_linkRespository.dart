import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart';
import 'package:gandalverse/data/telegram_client.dart';
import 'package:gandalverse/di/global_dependencies.dart';
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
      {bool? isSubscribed,
      bool? isClaimed,
      DateTime? subscribeAt,
      double? reward}) async {
    final index = socialLinksData.indexWhere((link) => link.id == id);
    if (index == -1) return;

    final updatedLink = socialLinksData[index].rebuild((b) => b
      ..isSubscribed = isSubscribed ?? socialLinksData[index].isSubscribed
      ..isClaimed = isClaimed ?? socialLinksData[index].isClaimed
      ..subscribeAt = subscribeAt?.toUtc() ?? socialLinksData[index].subscribeAt
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
        // Chercher l'élément correspondant dans `localData`
        int indexToUpdate =
            localData.indexWhere((item) => isSameLink(item, jsonItem));

        if (indexToUpdate != -1) {
          // Si l'élément existe, on le met à jour
          mergedData[indexToUpdate] = SocialLinkModel((b) => b
            ..id = localData[indexToUpdate].id // Conserver l'ID existant
            ..description = jsonItem.description
            ..image = jsonItem.image
            ..isSubscribed = localData[indexToUpdate]
                .isSubscribed // Conserver le statut d'abonnement
            ..subscriptionLink = jsonItem.subscriptionLink
            ..reward = jsonItem.reward
            ..title = jsonItem.title
            ..isClaimed = localData[indexToUpdate].isClaimed
            ..subscribeAt = localData[indexToUpdate].subscribeAt
            ..isVisible = jsonItem.isVisible);
          log("Mise à jour de l'élément à l'index $indexToUpdate");
        } else {
          // Si l'élément n'existe pas, on l'ajoute
          mergedData.add(SocialLinkModel((b) => b
            ..id = jsonItem.id // Utiliser l'ID du nouvel élément
            ..description = jsonItem.description
            ..image = jsonItem.image
            ..isSubscribed = jsonItem.isSubscribed
            ..subscriptionLink = jsonItem.subscriptionLink
            ..reward = jsonItem.reward
            ..title = jsonItem.title
            ..isClaimed = false
            ..subscribeAt = null
            ..isVisible = jsonItem.isVisible));
          log("Ajout d'un nouvel élément : ${jsonItem.title}");
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

  Future<void> setSubscriptionStatus(String id, bool isSubscribed ) async {
    // Rechercher le lien par son id
    final index = socialLinksData.indexWhere((link) => link.id == id);

    if (index != -1) {
      // Mettre à jour le champ isSubscribed
      if (isSubscribed == socialLinksData[index].isSubscribed) return;
      final updatedLink = socialLinksData[index].rebuild((b) => b
        ..isSubscribed = isSubscribed
        ..subscribeAt = DateTime.now().toUtc()
        ..isClaimed = false);

      socialLinksData[index] = updatedLink;

      // Sauvegarder la mise à jour dans les SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final jsonString =
          json.encode(socialLinksData.map((link) => link.toJson()).toList());
      await prefs.setString(socialLinksSaveKey, jsonString);

      notifyListeners();
    }
  }

  Future<void> setLinkIsClaimed(String id) async{
 // Rechercher le lien par son id
    final index = socialLinksData.indexWhere((link) => link.id == id);

    if (index != -1) {
      // Mettre à jour lelink status 
      final updatedLink = socialLinksData[index].rebuild((b) => b
        ..isSubscribed = true
        ..isClaimed = true);

      socialLinksData[index] = updatedLink;

      // Sauvegarder la mise à jour dans les SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final jsonString =
          json.encode(socialLinksData.map((link) => link.toJson()).toList());
      await prefs.setString(socialLinksSaveKey, jsonString);

      notifyListeners();
    }
  }

  // Dans SocialLinkModel ou SocialLinkService
  Future<void> openLinkAndUpdateStatus(String id, String url) async {
    try {
      if (await canLaunchUrl(Uri(scheme: url))) {
        // Ouvre le lien
        await launchUrl(Uri(scheme: url), mode: LaunchMode.inAppWebView);
        //TelegramClient _telegramClient = getIt<TelegramClient>();
        //_telegramClient.telegram.openTelegramLink(url);
        // Mettre à jour le statut après la visite
        await setSubscriptionStatus(id, true);
        print('Le lien a été visité et le statut a été mis à jour.');
      } else {
        throw 'Impossible d’ouvrir $url';
      }
    } catch (e) {
      print('Erreur lors de l’ouverture du lien: $e');
    }
  }

  //  Future<void> openLink(String id, String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Impossible d’ouvrir $url';
  //   }
  // }

  Duration getTimeUntil60Minutes() {
    final now = DateTime.now();
    final in60Minutes = now.add(Duration(minutes: 60));
    return in60Minutes.difference(now);
  }

  // Méthode pour obtenir le temps restant en heures, minutes et secondes
  Map<String, int> getTimeRemaining() {
    final duration = getTimeUntil60Minutes();
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return {
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }
}
