import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart';
import 'package:gandalverse/core/repositories/social_link_repo/social_link_repoExtension.dart';
import 'package:gandalverse/core/services/explorer_service/explorer_service_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

@singleton
class SocialLinkService with ChangeNotifier {
  String socialLinksJsonPath = "assets/json/socialLinksData.json";
  String socialLinksSaveKey = "socialLinksDataKey3";

  List<SocialLinkModel> socialLinksData = [];

  SocialLinkService() {
    loadSocialLinks();
  }

  void loadSocialLinks() async {
    final data = await loadAndMergeItems(
        (json) => SocialLinkModel.fromJson(
            json), // Fonction de transformation JSON -> Product
        (socilaLink) => socilaLink.toJson(),
        socialLinksSaveKey,
        socialLinksJsonPath,
        isSameLink);
    socialLinksData = List<SocialLinkModel>.from(data);
    notifyListeners();
  }

  Future<List<SocialLinkModel>> getSocialLinks() async {
    //   if (socialLinksData.isNotEmpty) return socialLinksData;
    final data = await loadAndMergeItems(
        // (json) => SocialLinkModel.fromJson(
        //     json), // Fonction de transformation JSON -> Product
        // (socilaLink) => socilaLink.toJson(),

        (json) => fromJson(json), // Fonction de transformation JSON -> Product
        (item) => toJson(item),
        socialLinksSaveKey,
        socialLinksJsonPath,
        isSameLink);
    notifyListeners();

    print("getSocialLinks => data ${data.length}");
    return List<SocialLinkModel>.from(data);
  }

  @override
  SocialLinkModel fromJson(Map<String, dynamic> json) =>
      SocialLinkModel.fromJson(json);

  @override
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
      {bool? isSubscribed, String? reward}) async {
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
}
