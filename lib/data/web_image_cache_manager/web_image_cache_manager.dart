import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/services.dart';

class WebImageCacheManager {
  static final WebImageCacheManager _instance = WebImageCacheManager._internal();
  final Map<String, String> _cache = {};

  factory WebImageCacheManager() {
    return _instance;
  }

  WebImageCacheManager._internal();

  Future<String> getImageAsBase64(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      return _cache[assetPath]!;
    } else {
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      final String base64String = base64Encode(bytes);
      _cache[assetPath] = base64String;
      return base64String;
    }
  }
}
