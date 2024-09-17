// ignore_for_file: avoid_print

import 'dart:async';

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

import 'widgets/fortune_spin/config/web_config.dart';
// Pour JSON parsing

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

// import 'dart:async';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

// // Remplacez ceci par votre fichier "themeColors.dart"
// import 'package:gandalverse/themes/color/themeColors.dart';
// import 'package:gandalverse/themes/images/appImages.dart';
// import 'package:gandalverse/widgets/customImageView.dart';
// import 'package:gandalverse/widgets/fortune_spin/wheel_data/wheel_constant.dart';
// import 'package:gandalverse/widgets/reward/reward_animation.dart';

// import 'widgets/fortune_spin/roll_btn.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fortune Wheel Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fortune Wheel Demo'),
//       ),
//       body: const FortuneWheelWidget(),
//     );
//   }
// }
/*
class FortuneWheelWidget extends StatefulWidget {
  const FortuneWheelWidget({super.key});

  @override
  State<FortuneWheelWidget> createState() => _FortuneWheelWidgetState();
}

class _FortuneWheelWidgetState extends State<FortuneWheelWidget> {
  // final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;

  StreamController<int> _selected = StreamController<int>();
  int _selectedIndex = 0;
  bool _isAnimating = false;
  bool isClaimed = false;

  @override
  void initState() {
    super.initState();
    // _selected = StreamController<int>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selected.stream.listen((index) {
        setState(() {
          _selectedIndex = index;
        });
      });
    });
  }

  @override
  void dispose() {
    _selected.close();
    super.dispose();
  }

  void _handleRoll() {
    _selected.add(
      roll(Constants.fortuneValues.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          RollButtonWithPreview(
            selected: _selectedIndex,
            items: [], //Constants.fortuneValues,
            onPressed: _isAnimating
                ? null
                : !isClaimed
                    ? _handleRoll
                    : null,
          ),
          Text('selectedIndex $_selectedIndex'),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-1, -1), color: Colors.grey.shade200)
                  ],
                  image: DecorationImage(
                      image: AssetImage(Images.circleBorder),
                      fit: BoxFit.contain)),
              child: Container(
                // constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Themecolors.Color3.withOpacity(0.9),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple.shade200,
                      Colors.deepPurple.shade300,
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade500,
                      Colors.deepPurple.shade600,
                      const Color(0xFF512DA8),
                    ],
                  ),
                  border: Border.all(color: Colors.deepPurple, width: 1.0),
                ),
                padding: const EdgeInsets.all(2),
                child: FortuneWheel(
                  alignment: Alignment.topCenter,
                  selected: _selected.stream,
                  onAnimationStart: () {
                    setState(() {
                      _isAnimating = true;
                    });
                  },
                  onAnimationEnd: () {
                    setState(() {
                      _isAnimating = false;
                      isClaimed = true;
                      RewardAnimation.show(context);
                      Future.delayed(const Duration(seconds: 3), () {
                        RewardAnimation.hide(context);
                      });
                    });
                  },
                  onFling: !isClaimed ? _handleRoll : null,
                  hapticImpact: HapticImpact.heavy,
                  curve: FortuneCurve.spin,
                  animateFirst: false,
                  indicators: [
                    FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: CustomImageView(
                          imagePath: Images.down_arrow,
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        )
                        /* TriangleIndicator(
                        color: Colors.white,
                        elevation: 5.0,
                      ),*/
                        ),
                  ],
                  items: [
                    for (Map<String, dynamic> it in Constants.fortuneValues)
                      FortuneItem(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  it['coins'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomImageView(
                                  imagePath: it['coins'] == 'bonus'
                                      ? Images.game_gift
                                      : Images.coin_dollar,
                                  fit: BoxFit.contain,
                                  height: it['coins'] == 'bonus' ? 30 : 20,
                                  width: it['coins'] == 'bonus' ? 30 : 20,
                                ),
                              ]),
                          onTap: () => print(it['coins'])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/