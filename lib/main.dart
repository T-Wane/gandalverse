// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:math';

import 'package:draggable_widget/draggable_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/firebase_options.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gandalverse/init.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
//import 'package:telegram_web_app/telegram_web_app.dart';
import 'animations/coinsAnimations_test2.dart';
import 'animations/coinsAnomations_test1.dart';
import 'screens/home.page.dart';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';

// WebViewEnvironment? webViewEnvironment;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyBq--4t1eJlvVRGq-BK6n4iwqzLqYXSzis',
      appId: '1:366940087617:web:876ada4485b421a10e6dc0',
      messagingSenderId: '366940087617',
      projectId: 'gandalversego',
      authDomain: 'gandalversego.firebaseapp.com',
      storageBucket: 'gandalversego.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }
  WebViewPlatform.instance = WebWebViewPlatform();
  try {
    if (TelegramWebApp.instance.isSupported) {
      await TelegramWebApp.instance.ready();
      Future.delayed(
          const Duration(seconds: 1), TelegramWebApp.instance.expand);
    }
  } catch (e) {
    print("Error happened in Flutter while loading Telegram $e");
    // add delay for 'Telegram not loading sometimes' bug
    await Future.delayed(const Duration(milliseconds: 200));
    main();
    return;
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark),
  );

  try {
    if (TelegramWebApp.instance.isSupported) {
      await TelegramWebApp.instance.ready();
      Future.delayed(
          const Duration(seconds: 1), TelegramWebApp.instance.expand);
    }
  } catch (e) {
    print("Error happened in Flutter while loading Telegram $e");
    // add delay for 'Telegram seldom not loading' bug
    await Future.delayed(const Duration(milliseconds: 200));
    main();
    return;
  }

  FlutterError.onError = (details) {
    print("Flutter error happened: $details");
  };

  runApp(MyApp() //InitializationPage()
      ); //InitializationPage
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset _offset = Offset.zero;

  final dragController = DragController();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GandalVerse',
      debugShowCheckedModeBanner: false,
      theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),
      /* builder: (_, child) {
          return Stack(
            children: [
              child!,
              Positioned(
                left: _offset.dx,
                top: _offset.dy,
                child: /**/
                    GestureDetector(
                  onPanUpdate: (details) {
                    setState(() => _offset += details.delta);
                    print("is clicked");
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
             
            ],
          );
        },*/
      home: MyHomePage(),
    );
  }
}
  