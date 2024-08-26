// ignore_for_file: avoid_print
import 'package:draggable_widget/draggable_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gandalverse/core/providers/charge_provider.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart';
import 'package:gandalverse/data/firebase_client.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/new_design_screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'data/telegram_client.dart';
import 'screens/home.page.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // await getIt<FirebaseClient>().initializeApp();
  //await getIt<TelegramClient>().initializeApp();
  WebViewPlatform.instance = WebWebViewPlatform();

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<UserProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<TapAndEarnRepository>()),
        ChangeNotifierProvider(create: (_) => getIt<ChargeManager>()),
      ],
      builder: ((context, child) =>
          MyApp()), // /*InitializationPage()*/ MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset _offset = Offset.zero;

  final dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GandalVerse',
      debugShowCheckedModeBanner: false,
     // theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),
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
      home: GoogleMapPage()
      //MyHomePage(),
    );
  }
}
