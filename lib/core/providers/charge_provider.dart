import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

@singleton
class ChargeManager with ChangeNotifier {
  int _points = 0;
  final int maxPoints = 100;
  final int increment = 1;
  final int decrement = 1;
  final int incrementIntervalSeconds = 1;
  late Timer _timer;

  ChargeManager() {
    _loadPoints();
    _startTimer();
  }

  int get points => _points;

  Future<void> _loadPoints() async {
    final prefs = await SharedPreferences.getInstance();
    final lastExitTime = prefs.getInt('last_exit_time');
    final savedPoints = prefs.getInt('points') ?? 0;

    if (lastExitTime != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final elapsedTime = (currentTime - lastExitTime) ~/ 1000;
      final additionalPoints =
          (elapsedTime ~/ incrementIntervalSeconds) * increment;
      _points = savedPoints + additionalPoints;
      if (_points > maxPoints) _points = maxPoints;
    } else {
      _points = savedPoints;
    }

    notifyListeners();
  }

  void _startTimer() {
    _timer =
        Timer.periodic(Duration(seconds: incrementIntervalSeconds), (timer) {
      if (_points < maxPoints) {
        _points += increment;
        if (_points > maxPoints) {
          _points = maxPoints;
        }
        _savePoints();
        notifyListeners();
      }
    });
  }

  Future<void> _savePoints() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', _points);
  }

  void decrementPoints() {
    if (_points >= decrement) {
      _points -= decrement;
    } else {
      _points = 0;
    }
    _savePoints();
    notifyListeners();
  }

  Future<void> _saveExitTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('last_exit_time', currentTime);
  }

  List<Color> getGradient() {
    if (_points < maxPoints * 0.25) {
      return [
        Colors.red.shade200,
        Colors.red.shade400,
      ];
    } else if (_points < maxPoints * 0.5) {
      return [
        Colors.orange.shade200,
        Colors.orange.shade400,
      ];
    } else if (_points < maxPoints * 0.75) {
      return [
        Colors.yellow.shade200,
        Colors.yellow.shade400,
      ];
    } else {
      return [
        Colors.green.shade400,
        Colors.green.shade600,
      ];
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _saveExitTime();
    super.dispose();
  }
}
