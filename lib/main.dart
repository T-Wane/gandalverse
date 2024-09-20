// ignore_for_file: avoid_print

import 'dart:async';
 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gandalverse/core/providers/charge_provider.dart';
import 'package:gandalverse/core/providers/player_provider.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/repositories/social_link_repo/social_linkRespository.dart';
import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'core/route/router_navigator.dart';
import 'core/services/explorer_service/explorer_service.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

// Dépendance FFI (importée conditionnellement)
import 'package:flutter/foundation.dart' show kIsWeb;

import 'widgets/fortune_spin/config/web_config.dart';
// Pour JSON parsing
//import  "dart:ffi";
 
// import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // await getIt<FirebaseClient>().initializeApp();
  //await getIt<TelegramClient>().initializeApp();
  WebViewPlatform.instance = WebWebViewPlatform();
  configureApp();

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
        ChangeNotifierProvider(create: (_) => getIt<ExplorerService>()),
        ChangeNotifierProvider(create: (_) => getIt<SocialLinkService>()),
        ChangeNotifierProvider(create: (_) => getIt<PlayerProvider>()),
      ],
      builder: ((context, child) => MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _rootNavigator;

  @override
  void initState() {
    super.initState();
    _rootNavigator = RootNavigator().makeRoutes;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: MaterialApp.router(
        routerConfig: _rootNavigator,
        // routerDelegate: RootNavigator().makeRoutes.routerDelegate,
        // routeInformationParser:
        //     RootNavigator().makeRoutes.routeInformationParser,
        title: 'GandalVerse',
        debugShowCheckedModeBanner: false,
        // theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),

        //MyHomePage(),
      ),
    );
  }
}
 