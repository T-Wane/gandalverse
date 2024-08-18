import 'dart:async';

class ClickManager {
  int _clickCount = 0;
  final Duration _updateInterval = Duration(milliseconds: 100);
  Timer? _timer;

  void onClick(Function updateUserCoins) {
    _clickCount++;

    // Démarre ou redémarre le timer pour gérer les clics
    _timer?.cancel();
    _timer = Timer(_updateInterval, () {
      updateUserCoins(_clickCount);
      _clickCount = 0; // Réinitialiser le compteur après la mise à jour
    });
  }
}
