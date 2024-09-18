import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class MyProfitManager {
  UserProvider _userProvider;
  static const String _lastProfitClaimDateKey = 'last_profit_claim_date';
  static const String _isProfitClaimedKey = 'profitIsClaimed';
  int reward = 15000;
  Duration spinCooldown = Duration(hours: 1); // Cooldown de 1 heures

  MyProfitManager(this._userProvider);

  // Vérifie si la récompense du spin est disponible
  Future<bool> canClaimedProfit() async {
    final prefs = await SharedPreferences.getInstance();
    final lastProfitClaim = prefs.getString(_lastProfitClaimDateKey);

    if (lastProfitClaim == null) {
      // Si aucune réclamation de spin précédente n'existe, le spin est disponible
      return true;
    }

    final lastProfitDate = DateTime.parse(lastProfitClaim);
    final timeSinceLastProfit = DateTime.now().difference(lastProfitDate);

    // Vérifier si le temps écoulé depuis le dernier spin est supérieur au cooldown
    return timeSinceLastProfit >= spinCooldown;
  }

  // Réclamer la récompense du spin
  Future<void> claimProfit() async {
    if (!await canClaimedProfit()) {
      // Si la récompense n'est pas disponible, ne rien faire
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    // Mise à jour des coins de l'utilisateur
    if (_userProvider.user != null) {
      final updatedUser = _userProvider.user!.rebuild(
          (b) => b..coins = ((_userProvider.user?.coins ?? 0) + reward));
      _userProvider.updateUserPointLocal(updatedUser);
    }

    // Enregistrer la date actuelle comme la dernière réclamation de spin
    await prefs.setString(
        _lastProfitClaimDateKey, DateTime.now().toIso8601String());

    // Marquer la récompense comme réclamée
    await prefs.setBool(_isProfitClaimedKey, true);
  }

  // Méthode pour calculer le temps restant jusqu'à ce que le spin soit de nouveau disponible
  Future<Duration> getTimeUntilNextClaim() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSpinClaim = prefs.getString(_lastProfitClaimDateKey);

    if (lastSpinClaim == null) {
      // Si aucune réclamation de spin précédente, le spin est immédiatement disponible
      return Duration.zero;
    }

    final lastSpinDate = DateTime.parse(lastSpinClaim);
    final timeSinceLastSpin = DateTime.now().difference(lastSpinDate);

    // Calculer le temps restant jusqu'à la disponibilité du spin
    if (timeSinceLastSpin >= spinCooldown) {
      return Duration.zero; // Spin disponible
    } else {
      return spinCooldown -
          timeSinceLastSpin; // Temps restant avant disponibilité
    }
  }

  // Méthode pour obtenir le temps restant en heures, minutes et secondes
  Future<Map<String, int>> getTimeRemaining() async {
    final duration = await getTimeUntilNextClaim();
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return {
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }
}
