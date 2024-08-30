import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class DailyRewardManager {
  UserProvider _userProvider;
  static const String _lastLoginDateKey = 'lastLoginDate';
  static const String _currentDayKey = 'currentDay';
  static const String _isRewardClaimedKey = 'isRewardClaimed'; // Nouvelle clé
  final List<int> dailyCoins = [200, 350, 450, 600, 700, 850, 1000];

  DailyRewardManager(this._userProvider);

  Future<int> getCurrentDay() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDateStr = prefs.getString(_lastLoginDateKey);
    final lastDay = prefs.getInt(_currentDayKey) ?? 1;

    DateTime lastLoginDate;
    if (lastDateStr != null) {
      lastLoginDate = DateTime.parse(lastDateStr);
    } else {
      lastLoginDate = DateTime.now();
    }

    final now = DateTime.now();
    final difference = now.difference(lastLoginDate).inDays;

    int currentDay;
    if (difference == 1) {
      currentDay = lastDay < 7 ? lastDay + 1 : 1;
      // Réinitialiser l'état de la récompense pour le nouveau jour
      await prefs.setBool(_isRewardClaimedKey, false);
    } else if (difference > 1) {
      currentDay = 1;
      // Réinitialiser l'état de la récompense si l'utilisateur a manqué plusieurs jours
      await prefs.setBool(_isRewardClaimedKey, false);
    } else {
      currentDay = lastDay;
    }

    await prefs.setString(_lastLoginDateKey, now.toIso8601String());
    await prefs.setInt(_currentDayKey, currentDay);

    return currentDay;
  }

  Future<int> getRewardForToday() async {
    int currentDay = await getCurrentDay();
    return dailyCoins[currentDay - 1];
  }

  Future<bool> isRewardClaimed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isRewardClaimedKey) ?? false;
  }

  Future<void> claimReward() async {
    if (await isRewardClaimed()) {
      // Si la récompense a déjà été réclamée, ne rien faire
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    int reward = await getRewardForToday();
    if (_userProvider.user != null) {
      final updatedUser = _userProvider.user!.rebuild(
          (b) => b..coins = ((_userProvider.user?.coins ?? 0) + reward));
      _userProvider.updateUserPointLocal(updatedUser);
    }

    // Marquer la récompense comme réclamée
    await prefs.setBool(_isRewardClaimedKey, true);
  }
}
