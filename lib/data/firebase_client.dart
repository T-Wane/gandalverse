// ignore_for_file: avoid_classes_with_only_static_members

import "dart:io" show Platform;
import "package:firebase_core/firebase_core.dart";

class FirebaseClient {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "",
    appId: "",
    messagingSenderId: "",
    projectId: "",
    storageBucket: "",
  );

  static Future<FirebaseClient> init() async => FirebaseClient();

  Future<void> initializeApp() async {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(options: android);
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
  }
}
