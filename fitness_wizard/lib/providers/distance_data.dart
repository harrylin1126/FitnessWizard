import 'package:flutter/material.dart';

class DistanceData extends ChangeNotifier {
  double _totalDistance = 0;

  double get totalDistance => _totalDistance;

  void updateTotalDistance(double distance) {
    _totalDistance = distance;
    notifyListeners();
  }
}
