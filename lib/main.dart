// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:math';

import 'package:draggable_widget/draggable_widget.dart';
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

// Votre classe FlyCoinAnimation
class FlyCoinAnimation extends StatefulWidget {
  const FlyCoinAnimation({super.key});

  @override
  State<FlyCoinAnimation> createState() => FlyCoinAnimationState();
}

class FlyCoinAnimationState extends State<FlyCoinAnimation>
    with TickerProviderStateMixin {
  final List<AnimationItem> _animationItems = [];

  @override
  void dispose() {
    // Dispose all animation controllers when the widget is disposed
    for (var item in _animationItems) {
      item.controller.dispose();
    }
    super.dispose();
  }

  void _startAnimation() {
    final controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    final newAnimationItem = AnimationItem(controller: controller);

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
        setState(() {
          _animationItems.remove(newAnimationItem);
        });
      }
    });

    setState(() {
      _animationItems.add(newAnimationItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox.square(
              dimension: 200,
              child: PlayButton(
                onPressed: _startAnimation,
                initialIsPlaying: false,
                playIcon: const Icon(Icons.play_arrow),
                pauseIcon: const Icon(Icons.pause),
              ),
            ),
          ),
          ..._animationItems.map((animationItem) {
            final opacityAnimation =
                Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: animationItem.controller,
                curve: Curves.easeOut,
              ),
            );

            final radiusAnimation =
                Tween<double>(begin: 0.0, end: 100.0).animate(
              CurvedAnimation(
                parent: animationItem.controller,
                curve: Curves.easeOut,
              ),
            );

            return AnimatedBuilder(
              animation: animationItem.controller,
              builder: (context, child) {
                final angle =
                    (animationItem.controller.value * 2 * pi) % (2 * pi);
                final radius = radiusAnimation.value;
                final x = radius * cos(angle);
                final y = radius * sin(angle);

                return FadeTransition(
                  opacity: opacityAnimation,
                  child: Transform.translate(
                    offset: Offset(x, y),
                    child: Center(
                      child: Text(
                        '+1',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.purple.shade400,
                          fontFamily: "Aller",
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Classe PlayButton
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
          imagePath: Images.vr, // Remplacez par le chemin correct
          fit: BoxFit.contain,
          color: Colors.white,
          height: 100,
          width: 150,
        ),
        onPressed: widget.onPressed, // Appel de la fonction de rappel
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

class AnimationItem {
  AnimationItem({required this.controller});
  final AnimationController controller;
}
