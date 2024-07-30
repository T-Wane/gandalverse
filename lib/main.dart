// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  /* try {
      if (TelegramWebApp.instance.isSupported) {
        await TelegramWebApp.instance.ready();
        Future.delayed(const Duration(seconds: 1), TelegramWebApp.instance.expand);
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
*/

  runApp(MyApp()); //InitializationPage
}

/*
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset _offset = Offset.zero;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GandalVerse',
        debugShowCheckedModeBanner: false,
        theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),
        builder: (_, child) {
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
                  
                  child: AbsorbPointer(
                    absorbing: true,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        home: MyHomePage());
  }
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 250,
            width: 250,
            child: PlayButton(
              pauseIcon: const Icon(Icons.pause, color: Colors.black, size: 90),
              playIcon:
                  const Icon(Icons.play_arrow, color: Colors.black, size: 90),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  PlayButton({
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
  }) : assert(onPressed != null);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(seconds: 4);
  static const _kRotationDuration = Duration(seconds: 5);

  late bool isPlaying;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));
    _scaleController.forward();
    super.initState();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: CustomImageView(
          imagePath: Images.vr,
          fit: BoxFit.contain,
          color: Colors.white,//.deepPurple.shade400
          height: 100,
          width: 150,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(
                color: Colors.blueAccent.shade400,
                scale: _scale * 0.95,
                rotation: _rotation),
            /* Blob(
                color: const Color(0xff4ac7b7),
                scale: _scale,
                rotation: _rotation * 1.5 - 30),*/
            Blob(
                color: Colors.purple.shade400.withOpacity(0.5),
                scale: _scale * 0.97,
                rotation: _rotation * 2 - 60),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color3.withOpacity(0.9),
                border: Border.all(color: Colors.white, width: 3.0)),
            child: AnimatedSwitcher(
              duration: _kToggleDuration,
              child: _buildIcon(isPlaying),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}
