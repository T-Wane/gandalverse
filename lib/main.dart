// // ignore_for_file: avoid_print

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gandalverse/core/providers/charge_provider.dart';
// import 'package:gandalverse/core/providers/user_provider.dart';
// import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart';
// import 'package:gandalverse/di/global_dependencies.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:webview_flutter_web/webview_flutter_web.dart';
// import 'core/route/router_navigator.dart';
// import 'core/services/explorer_service/explorer_service.dart';
// import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
// // Pour JSON parsing 

// import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

 
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await configureDependencies();
//   // await getIt<FirebaseClient>().initializeApp();
//   //await getIt<TelegramClient>().initializeApp();
//   WebViewPlatform.instance = WebWebViewPlatform();
//     // Require Hybrid Composition mode on Android.
//   // final GoogleMapsFlutterPlatform mapsImplementation =
//   //     GoogleMapsFlutterPlatform.instance;
//   // if (mapsImplementation is GoogleMapsFlutterAndroid) {
//   //   // Force Hybrid Composition mode.
//   //   mapsImplementation.useAndroidViewSurface = true;
//   // }
//   // await initializeMapRenderer();


//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         systemNavigationBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//         statusBarIconBrightness: Brightness.dark),
//   ); 

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => getIt<UserProvider>()),
//         ChangeNotifierProvider(create: (_) => getIt<TapAndEarnRepository>()),
//         ChangeNotifierProvider(create: (_) => getIt<ChargeManager>()),
//         ChangeNotifierProvider(create: (_) => getIt<ExplorerService>()),
//       ],
//       builder: ((context, child) =>
//           MyApp()), // /*InitializationPage()*/ MyApp()
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late final GoRouter _rootNavigator;

//   @override
//   void initState() {
//     super.initState();
//     _rootNavigator = RootNavigator().makeRoutes;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MediaQuery(
//       data: MediaQuery.of(context)
//           .copyWith(textScaler: const TextScaler.linear(1)),
//       child: MaterialApp.router(
//        routerConfig: _rootNavigator,
//         // routerDelegate: RootNavigator().makeRoutes.routerDelegate,
//         // routeInformationParser:
//         //     RootNavigator().makeRoutes.routeInformationParser,
//         title: 'GandalVerse',
//         debugShowCheckedModeBanner: false,
//         // theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),

//         //MyHomePage(),
//       ),
//     );
//   }
// }
 
 
// Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

// /// Initializes map renderer to the `latest` renderer type.
// ///
// /// The renderer must be requested before creating GoogleMap instances,
// /// as the renderer can be initialized only once per application context.
// Future<AndroidMapRenderer?> initializeMapRenderer() async {
//   if (_initializedRendererCompleter != null) {
//     return _initializedRendererCompleter!.future;
//   }

//   final Completer<AndroidMapRenderer?> completer =
//       Completer<AndroidMapRenderer?>();
//   _initializedRendererCompleter = completer;

//   WidgetsFlutterBinding.ensureInitialized();

//   final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
//   unawaited((platform as GoogleMapsFlutterAndroid)
//       .initializeWithRenderer(AndroidMapRenderer.latest)
//       .then((AndroidMapRenderer initializedRenderer) =>
//           completer.complete(initializedRenderer)));

//   return completer.future;
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gandalverse/core/providers/charge_provider.dart';
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
// Pour JSON parsing

import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // await getIt<FirebaseClient>().initializeApp();
  //await getIt<TelegramClient>().initializeApp();
  WebViewPlatform.instance = WebWebViewPlatform();
  // Require Hybrid Composition mode on Android.
  // final GoogleMapsFlutterPlatform mapsImplementation =
  //     GoogleMapsFlutterPlatform.instance;
  // if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //   // Force Hybrid Composition mode.
  //   mapsImplementation.useAndroidViewSurface = true;
  // }
  // await initializeMapRenderer();

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
      ],
      builder: ((context, child) =>
          MyApp()), // /*InitializationPage()*/ MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google static map demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

final retroMapStyle = [
  const MapStyle(
    element: StyleElement.geometry,
    rules: [
      StyleRule.color(Color(0xffebe3cd)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text,
    rules: const [
      StyleRule.color(Color(0xFF523735)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.stroke,
    rules: const [
      StyleRule.color(Color(0xFFf5f1e6)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry.stroke,
    feature: StyleFeature.administrative,
    rules: const [
      StyleRule.color(Color(0xFFc9b2a6)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry.stroke,
    feature: StyleFeature.administrative.landParcel,
    rules: const [
      StyleRule.color(Color(0xFFdcd2be)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.fill,
    feature: StyleFeature.administrative.landParcel,
    rules: const [
      StyleRule.color(Color(0xFFae9e90)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.landscape.natural,
    rules: const [
      StyleRule.color(Color(0xFFdfd2ae)),
    ],
  ),
  const MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.poi,
    rules: [
      StyleRule.color(Color(0xFFdfd2ae)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.fill,
    feature: StyleFeature.poi,
    rules: const [
      StyleRule.color(Color(0xFF93817c)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry.fill,
    feature: StyleFeature.poi.park,
    rules: const [
      StyleRule.color(Color(0xFFa5b076)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.fill,
    feature: StyleFeature.poi.park,
    rules: const [
      StyleRule.color(Color(0xFF447530)),
    ],
  ),
  const MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.road,
    rules: [
      StyleRule.color(Color(0xFFf5f1e6)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.road.arterial,
    rules: const [
      StyleRule.color(Color(0xFFfdfcf8)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.road.highway,
    rules: const [
      StyleRule.color(Color(0xFFf8c967)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry.stroke,
    feature: StyleFeature.road.highway,
    rules: const [
      StyleRule.color(Color(0xFFe9bc62)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.road.highway.controlledAccess,
    rules: const [
      StyleRule.color(Color(0xFFe98d58)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry.stroke,
    feature: StyleFeature.road.highway.controlledAccess,
    rules: const [
      StyleRule.color(Color(0xFFdb8555)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.fill,
    feature: StyleFeature.road.local,
    rules: const [
      StyleRule.color(Color(0xFF806b63)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.transit.line,
    rules: const [
      StyleRule.color(Color(0xFFdfd2ae)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.fill,
    feature: StyleFeature.transit.line,
    rules: const [
      StyleRule.color(Color(0xFF8f7d77)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.stroke,
    feature: StyleFeature.transit.line,
    rules: const [
      StyleRule.color(Color(0xFFebe3cd)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry,
    feature: StyleFeature.transit.station,
    rules: const [
      StyleRule.color(Color(0xFFdfd2ae)),
    ],
  ),
  MapStyle(
    element: StyleElement.geometry.fill,
    feature: StyleFeature.water,
    rules: const [
      StyleRule.color(Color(0xFFb9d3c2)),
    ],
  ),
  MapStyle(
    element: StyleElement.labels.text.fill,
    feature: StyleFeature.water,
    rules: const [
      StyleRule.color(Color(0xFF92998d)),
    ],
  ),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

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

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

/// Initializes map renderer to the `latest` renderer type.
///
/// The renderer must be requested before creating GoogleMap instances,
/// as the renderer can be initialized only once per application context.
Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
  unawaited((platform as GoogleMapsFlutterAndroid)
      .initializeWithRenderer(AndroidMapRenderer.latest)
      .then((AndroidMapRenderer initializedRenderer) =>
          completer.complete(initializedRenderer)));

  return completer.future;
}
