import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

abstract class QGService<T> {
  String get assetPath;
  String get storageKey;

  final _loadingController = StreamController<bool>.broadcast();

  Stream<bool> get loadingStream => _loadingController.stream;

  Future<List<T>> loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(storageKey);

    //log("####### loadItems ${jsonString}  # #############");

    if (jsonString == null) {
      jsonString = await rootBundle.loadString(assetPath);
      prefs.setString(storageKey, jsonString);
    }

    final List<dynamic> jsonData = json.decode(jsonString);
    // log("####### loadItems to list ${jsonData}  # #############");
    try {
      List<T> data = jsonData.map((data) => fromJson(data)).toList();
      // log("####### data loadItems to list ${jsonData}  # #############");
      return data;
    } catch (e, stacktrace) {
      log("######[ ERROR in loadItems $e ]######");
      log("######[ STACKTRACE $stacktrace ]######");
      return [];
    }
  }

  Future<void> saveItems(List<T> items) async {
    _loadingController.add(true);
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonData = items.map((item) => toJson(item)).toList();
      prefs.setString(storageKey, json.encode(jsonData));

      _loadingController.add(false);
    });
  }

  Future<void> saveItems2(List<T> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = items.map((item) => toJson(item)).toList();
    prefs.setString(storageKey, json.encode(jsonData));
  }

  Future<void> updateItem(String carteId, T updatedItem) async {
    final items = await loadItems();
    final index = items.indexWhere((item) => getCarteId(item) == carteId);
    if (index != -1) {
      items[index] = updatedItem;
      await saveItems(items);
    }
  }


  

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);
  String? getCarteId(T item);
}
