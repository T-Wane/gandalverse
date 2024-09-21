import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/repositories/dailyRewardRepository.dart';
import 'package:gandalverse/themes/color/themeColors.dart';

class CountdownTimer extends StatefulWidget {
  final DailyRewardManager rewardManager;

  const CountdownTimer({required this.rewardManager, Key? key})
      : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
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

  void _updateTimeRemaining() {
    setState(() {
      _timeRemaining = widget.rewardManager.getTimeRemaining();
    });
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
    return DefaultButton(
      backColor: Colors.grey.shade300,
      text: "Revenez Demain", //displayTime,
      elevation: 1.0,
      textColor: Colors.grey.shade600,
      fontSize: 14,
      height: 50,
      press: () {},
    );
  }
}
