import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/animations/shakeAnimation.dart';
import 'package:gandalverse/core/repositories/spinRewardRepository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../wheelSpin_fortune_modal.dart';

class SmallSpinWidget extends StatefulWidget {
  const SmallSpinWidget({
    super.key,
  });

  @override
  State<SmallSpinWidget> createState() => _SmallSpinWidgetState();
}

class _SmallSpinWidgetState extends State<SmallSpinWidget> {
  late Timer _timer;

  SpinRewardManager _spinRewardManager = getIt<SpinRewardManager>();
  Map<String, int> _timeRemaining = {'hours': 0, 'minutes': 0, 'seconds': 0};

  @override
  void initState() {
    super.initState();
    // Initialiser le décompte
    _startTimer();
  }

  void _startTimer() {
    _updateTimeRemaining(); // Mettre à jour immédiatement
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeRemaining(); // Mettre à jour chaque seconde
    });
  }

  void _updateTimeRemaining() async {
    _timeRemaining = await _spinRewardManager.getTimeRemaining();
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel(); // Annuler le timer pour éviter les fuites de mémoire
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _timeRemaining['hours'] ?? 0;
    final minutes = _timeRemaining['minutes'] ?? 0;
    final seconds = _timeRemaining['seconds'] ?? 0;

    String displayTime = '';

    if (hours > 0) {
      displayTime = '$hours h';
    }

    if (minutes > 0 || (hours > 0 && minutes == 0)) {
      if (displayTime.isNotEmpty) displayTime += ':';
      displayTime += '$minutes m';
    }

    if (seconds > 0 || (hours == 0 && minutes == 0)) {
      if (displayTime.isNotEmpty) displayTime += ':';
      displayTime += '$seconds s';
    }
    return Positioned(
      top: 70,
      left: 0,
      child: GestureDetector(
        onTap: () {
          WheelspinFortuneModal.show(
            context,
          );
        },
        child: PointerInterceptor(
          debug: false,
          child: ShakeAnimation(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 1.0,
                  shadowColor: Themecolors.greyDeep.withOpacity(0.5),
                  surfaceTintColor: Colors.transparent,
                  shape: const CircleBorder(
                      /* side:
                        BorderSide(width: 1.0, color: Themecolors.ColorWhite)*/
                      ),
                  child: CustomImageView(
                    imagePath: Images.spin,
                    height: 40,
                    width: 40,
                    radius: BorderRadius.circular(20),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Themecolors.ColorWhite.withOpacity(0.2),
                          width: 1.0),
                      color: Themecolors.ColorWhite,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: (hours > 0 && minutes == 0 && seconds == 0)
                            ? displayTime.trim()
                            : "Lancer",
                        style: const TextStyle(
                          color: Themecolors.greyDeep,
                          fontSize: 12,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
