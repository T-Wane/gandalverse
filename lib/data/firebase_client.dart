// ignore_for_file: avoid_classes_with_only_static_members

import "dart:io" show Platform;
import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";

class FirebaseClient {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBq--4t1eJlvVRGq-BK6n4iwqzLqYXSzis',
    appId: '1:366940087617:web:876ada4485b421a10e6dc0',
    messagingSenderId: '366940087617',
    projectId: 'gandalversego',
    authDomain: 'gandalversego.firebaseapp.com',
    storageBucket: 'gandalversego.appspot.com',
  );

  static Future<FirebaseClient> init() async => FirebaseClient();

  Future<void> initializeApp() async {
    if (kIsWeb) {
      await Firebase.initializeApp(options: web);
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
  }
}
