// import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
// import 'package:gandalverse/core/repositories/social_link_repo/social_linkRespository.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/services.dart' show rootBundle;

// extension SocialLinkExtension<T> on SocialLinkService {

 

//   /// Fonction pour charger, comparer et fusionner les données JSON avec les données locales
//  Future<List<T>> loadAndMergeItems<T>(
//     T Function(Map<String, dynamic>)
//         fromJson, // Fonction pour convertir le JSON en objet T
//     Map<String, dynamic> Function(T)
//         toJson, // Fonction pour convertir un objet T en JSON
//     String storageKey, // Clé pour les SharedPreferences
//     String assetPath, // Chemin du fichier JSON dans les assets
//     bool Function(T localItem, T jsonItem)
//         isSameItem, // Fonction pour identifier si deux éléments sont les mêmes
//   ) async {
//     try {
//       // 1. Récupérer les SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       // 2. Charger les données locales de l'utilisateur
//       String? localJsonString = prefs.getString(storageKey);
//       List<T> localData = [];

//       if (localJsonString != null) {
//         final List<dynamic> localJsonData = json.decode(localJsonString);
//         localData = localJsonData
//             .map((item) => fromJson(item as Map<String, dynamic>))
//             .toList();
//       }
//       print("localData => $localData ${localData.length}");
//       // 3. Charger les données depuis le fichier JSON (données administratives)
//       String jsonString = await rootBundle.loadString(assetPath);
//       print("jsonAdminData jsonString => $jsonString");
//       final List<dynamic> jsonData = json.decode(jsonString);
//       List<T> jsonAdminData = jsonData
//           .map((item) => fromJson(item as Map<String, dynamic>))
//           .toList();

//       print("jsonAdminData => $jsonAdminData \n ${jsonAdminData.length}");
//       // 4. Fusionner les données locales avec les données JSON
//       // On fusionne en remplaçant les données locales si elles existent, sinon en les ajoutant
//       List<T> mergedData = localData;

//       for (T jsonItem in jsonAdminData) {
//         // Vérifier si l'élément du JSON existe déjà dans les données locales
//         T? localItem;
// // Parcourir la liste `localData` pour trouver un élément qui correspond
//         for (T item in localData) {
//           if (isSameItem(item, jsonItem)) {
//             localItem = item;
//             break; // On sort de la boucle dès qu'on trouve une correspondance
//           }
//         }

//         if (localItem == null) {
//           // Si l'élément JSON n'existe pas dans les données locales, on l'ajoute
//           mergedData.add(jsonItem);
//         } else {
//           // Si l'élément JSON existe dans les données locales, on garde l'élément local (on pourrait le mettre à jour selon certaines conditions)
//           // mergedData.add(localItem); // L'élément local reste inchangé dans ce cas
//           print("L'élément local reste inchangé dans ce cas");
//         }
//       }

//       // 5. Sauvegarder les données fusionnées localement
//       List<Map<String, dynamic>> jsonToSave =
//           mergedData.map((item) => toJson(item)).toList();
//       await prefs.setString(storageKey, json.encode(jsonToSave));

//       return mergedData;
//     } catch (e, stacktrace) {
//       // 6. Gestion des erreurs et affichage du stacktrace
//       print("######[ ERROR in loadAndMergeItems: $e ]######");
//       log("######[ ERROR in loadAndMergeItems: $e ]######");
//       log("######[ STACKTRACE: $stacktrace ]######");
//       return []; // Retourner une liste vide en cas d'erreur
//     }
//   }
 
//   Future<List<T>> loadItems(T Function(Map<String, dynamic>) fromJson,
//       String storageKey, String assetPath) async {
//       List<T> data = await loadAndMergeItems(
//         (json) => fromJson(json), // Fonction de transformation JSON -> Product
//         (carteData) => toJson(carteData),
//         storageKey,
//         assetPath,
//         isSameLink);

//     return data;
//   }
// }

// // // Interface pour garantir la sérialisation JSON
// // abstract class JsonSerializable {
// //   JsonSerializable fromJson(Map<String, dynamic> json);
// //   Map<String, dynamic> toJson();
// // }
