// ignore_for_file: avoid_classes_with_only_static_members

import "dart:io" show Platform;
import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";

class FirebaseClient {
  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyDgdJn-vTKTijPbhn15yKRW-PX6OyC1CzU",
      authDomain: "gandalverselive.firebaseapp.com",
      projectId: "gandalverselive",
      storageBucket: "gandalverselive.appspot.com",
      messagingSenderId: "894133258853",
      appId: "1:894133258853:web:a1f247cd24df438756948c",
      measurementId: "G-2W1MRMZMZ4");
  static Future<FirebaseClient> init() async {
    await initializeApp();
    return FirebaseClient();
  }

  static Future<void> initializeApp() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDgdJn-vTKTijPbhn15yKRW-PX6OyC1CzU",
              authDomain: "gandalverselive.firebaseapp.com",
              projectId: "gandalverselive",
              storageBucket: "gandalverselive.appspot.com",
              messagingSenderId: "894133258853",
              appId: "1:894133258853:web:a1f247cd24df438756948c",
              measurementId: "G-2W1MRMZMZ4"));
    } else {
      await Firebase.initializeApp();
    }
  }
}
