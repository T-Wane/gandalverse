// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDgdJn-vTKTijPbhn15yKRW-PX6OyC1CzU',
    appId: '1:894133258853:web:a1f247cd24df438756948c',
    messagingSenderId: '894133258853',
    projectId: 'gandalverselive',
    authDomain: 'gandalverselive.firebaseapp.com',
    storageBucket: 'gandalverselive.appspot.com',
    measurementId: 'G-2W1MRMZMZ4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6b4Y3lmffOu559OMemgBE-wPvtnibb30',
    appId: '1:894133258853:android:79b39ed8ad442b5c56948c',
    messagingSenderId: '894133258853',
    projectId: 'gandalverselive',
    storageBucket: 'gandalverselive.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUGohFA7t0-4wPFQwJlZxVz8ZtthG_c7k',
    appId: '1:894133258853:ios:f8b65458da3bfc1256948c',
    messagingSenderId: '894133258853',
    projectId: 'gandalverselive',
    storageBucket: 'gandalverselive.appspot.com',
    iosBundleId: 'com.example.gandalverse',
  );
}