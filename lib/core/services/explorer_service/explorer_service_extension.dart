import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
import 'explorer_service.dart';

extension ExplorerServiceExtension<T> on ExplorerService {
  Future<List<T>> loadItems(T Function(Map<String, dynamic>) fromJson,
      String storageKey, String assetPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(storageKey);

    if (jsonString == null) {
      jsonString = await rootBundle.loadString(assetPath);
      prefs.setString(storageKey, jsonString);
    }
    final List<dynamic> jsonData = json.decode(jsonString);
    try {
      List<T> data = jsonData
          .map((data) => fromJson(data as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e, stacktrace) {
      //log("######[ ERROR in loadItems $e ]######");
      //log("######[ STACKTRACE $stacktrace ]######");
      return [];
    }
  }
}

// // Interface pour garantir la sérialisation JSON
// abstract class JsonSerializable {
//   JsonSerializable fromJson(Map<String, dynamic> json);
//   Map<String, dynamic> toJson();
// }
