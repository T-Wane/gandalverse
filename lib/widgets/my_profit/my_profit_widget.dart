import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/animations/shakeAnimation.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/repositories/myProfitRepository.dart';
import 'package:gandalverse/core/repositories/spinRewardRepository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/my_profit/my_profit_modal.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class MyProfitWidget extends StatefulWidget {
  MyProfitWidget({super.key, this.boutonStyle = false, this.claimed});

  bool boutonStyle;
  VoidCallback? claimed;

  @override
  State<MyProfitWidget> createState() => _MyProfitWidgetState();
}

class _MyProfitWidgetState extends State<MyProfitWidget> {
  late Timer _timer;

  MyProfitManager _myProfitManager = getIt<MyProfitManager>();
  Map<String, int> _timeRemaining = {'hours': 0, 'minutes': 0, 'seconds': 0};

  @override
  void initState() {
    super.initState();
    // Initialiser le décompte
    _startTimer();
  }

  void _startTimer() {
    checkProfitIsAvailable();
    _updateTimeRemaining(); // Mettre à jour immédiatement
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeRemaining(); // Mettre à jour chaque seconde
    });
  }

  void _updateTimeRemaining() async {
    _timeRemaining = await _myProfitManager.getTimeRemaining();
    setState(() {});
  }

  void checkProfitIsAvailable() async {
    await _myProfitManager.canClaimedProfit();
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

    bool canClaimed =
        (hours == 0 && minutes == 0 && seconds == 0) ? true : false;
    return !widget.boutonStyle
        ? Positioned(
            top: 110,
            left: 0,
            child: /*ShakeAnimation(
                child: */
                GestureDetector(
              onTap: () {
                print("show spin");
                //if (canClaimed && !widget.boutonStyle) {
                MyProfitModal.show(
                  context,
                );
                // }
              },
              child: PointerInterceptor(
                debug: false,
                child: SizedBox.square(
                  dimension: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          elevation: 0.0,
                          color: Colors.transparent,
                          //  shadowColor: Themecolors.greyDeep.withOpacity(0.5),
                          surfaceTintColor: Colors.transparent,
                          // shape: const CircleBorder(
                          //     /* side:
                          //   BorderSide(width: 1.0, color: Themecolors.ColorWhite)*/
                          //     ),
                          child: CustomImageView(
                            imagePath: Images.gold,
                            height: 40,
                            width: 40,
                            //radius: BorderRadius.circular(20),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ]),
                ),
              ),
            ) //),
            )
        : GestureDetector(
            onTap: () {
              widget.claimed?.call();
              _myProfitManager.claimProfit().whenComplete(() => _startTimer());
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 1.2),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: canClaimed
                        ? [
                            Colors.deepPurple.shade300,
                            Colors.deepPurple.shade400,
                            Colors.deepPurple.shade500,
                            Colors.deepPurple.shade600,
                          ]
                        : [
                            Colors.grey.shade300,
                            Colors.grey.shade300,
                            Colors.grey.shade400,
                            Colors.grey.shade500
                          ]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontFamily: "Aller"),
                  child: Text(
                    canClaimed ? "Tourner" : displayTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Aller',
                      fontSize: 14,
                      color: canClaimed ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
