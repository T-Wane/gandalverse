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
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'core/route/router_navigator.dart';
import 'core/services/explorer_service/explorer_service.dart';
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
        ChangeNotifierProvider(create: (_) => getIt<ExplorerService>()),
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
        title: 'GandalVerse',
        debugShowCheckedModeBanner: false,
        // theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),

        //MyHomePage(),
      ),
    );
  }
}

class TelegramWebAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Uri uri = Uri.base; // Accède à l'URI complète
    final String? tgWebAppData = uri.queryParameters['tgWebAppData'];

    if (tgWebAppData != null) {
      // Traitement des données tgWebAppData
      // ...
    }

    return Scaffold(
      appBar: AppBar(title: Text('Telegram Web App')),
      body: Center(child: Text('Contenu de la webapp Telegram $tgWebAppData')),
    );
  }
}
