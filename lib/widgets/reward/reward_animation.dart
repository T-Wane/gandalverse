import 'package:flutter/material.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class RewardAnimation extends StatefulWidget {
  static void show(BuildContext context) => showDialog<void>(
        context: context,
        barrierColor: Colors.transparent,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => RewardAnimation(),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  RewardAnimation({Key? key}) : super(key: key);

  @override
  State<RewardAnimation> createState() => _RewardAnimationState();
}

class _RewardAnimationState extends State<RewardAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width * 0.8;
    final double height = size.height * 0.8;

    return WillPopScope(
      onWillPop: () async => true,
      child: Material(
        color: Colors.black12.withOpacity(0.1),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: width,
              maxHeight: height,
            ),
            margin: const EdgeInsets.all(8.0),
            decoration: ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Lottie.asset(
              Images.reward, // Assurez-vous que ce chemin est correct
              width: width,
              height: height,
              controller: _controller,
              fit: BoxFit.contain,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
        ),
      ),
    );
  }
}
