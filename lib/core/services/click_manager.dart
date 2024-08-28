import 'dart:async';

import 'package:gandalverse/core/providers/charge_provider.dart';

class ClickManager {
  int _clickCount = 0;
  final Duration _updateInterval = Duration(milliseconds: 5);
  Timer? _timer;
  ChargeManager _chargeManager;
  ClickManager(this._chargeManager);
  void onClick(Function updateUserCoins) {
    _clickCount++;
    _chargeManager.decrementPoints();
    // Démarre ou redémarre le timer pour gérer les clics
    _timer?.cancel();
    _timer = Timer(_updateInterval, () {
      updateUserCoins(_clickCount);
      _clickCount = 0; // Réinitialiser le compteur après la mise à jour
    });
  }
}
