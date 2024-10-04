import 'package:flutter/material.dart';

class AchievementData extends ChangeNotifier {
  List<bool> _achievementsUnlocked = [true, false, false, false, false];

  List<bool> get achievementsUnlocked => _achievementsUnlocked;

  void unlockAchievement(int index) {
    if (index >= 0 && index < _achievementsUnlocked.length) {
      _achievementsUnlocked[index] = true;
      notifyListeners();
    }
  }
}
