import 'dart:async';
import 'dart:math';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/achievement_data.dart';
import '../../providers/distance_data.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController _controller;
  LatLng _currentPosition = LatLng(23.4680, 120.4848);
  bool _isTracking = false;
  int _elapsedSeconds = 0;
  List<LatLng> _path = [];
  double _totalDistance = 0;
  double _caloriesBurned = 0;
  late StreamSubscription<Position> _positionStreamSubscription;
  Timer? _timer;
  final double _userWeight = 70; // kg

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (!serviceEnabled) {
      print("Service disabled");
    }

    try {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print("permission deny");
      }

      if (permission == LocationPermission.deniedForever) {
        print("permission 0.0");
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        print(_currentPosition);
      });

      _controller.animateCamera(CameraUpdate.newLatLng(_currentPosition));

      if (_isTracking) {
        initLocationSubscription();
      }
    } catch (err) {
      throw Exception("Fail to fetch user coordinates $err");
    }
  }

  void initLocationSubscription() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen((Position newPosition) {
      setState(() {
        LatLng newLatLng = LatLng(newPosition.latitude, newPosition.longitude);
        if (_isTracking) {
          _path.add(newLatLng);
          if (_path.length > 1) {
            double distance = _calculateDistance(
              _path[_path.length - 2],
              _path[_path.length - 1],
            );
            _totalDistance += distance;
            _caloriesBurned += _calculateCalories(distance);

            // 更新 DistanceData
            Provider.of<DistanceData>(context, listen: false).updateTotalDistance(_totalDistance);

            // 更新成就狀態
            _checkAchievements();
          }
        }
        _currentPosition = newLatLng;
      });
    });
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000; // in meters
    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLng = _degreesToRadians(end.longitude - start.longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double _calculateCalories(double distance) {
    // Convert distance from meters to kilometers
    double distanceInKm = distance / 1000;
    // Calculate calories burned
    return distanceInKm * _userWeight * 1.036;
  }

  void _toggleTracking() {
    setState(() {
      _isTracking = !_isTracking;
      if (_isTracking) {
        _path.clear();
        _totalDistance = 0;
        _caloriesBurned = 0;
        _elapsedSeconds = 0;
        _startTimer();
        _getCurrentLocation();
      } else {
        _positionStreamSubscription.cancel();
        _timer?.cancel();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _checkAchievements() {
    final achievementData = Provider.of<AchievementData>(context, listen: false);

    if (_elapsedSeconds >= 30) { // 5 minutes
      achievementData.unlockAchievement(1);
    }
    if (_elapsedSeconds >= 360) { // 1 hour
      achievementData.unlockAchievement(2);
    }
    if (_totalDistance >= 100) { // 1 km
      achievementData.unlockAchievement(3);
    }
    if (_totalDistance >= 1000) { // 10 km
      achievementData.unlockAchievement(4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 450,
              height: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentPosition,
                  zoom: 17,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("initLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentPosition,
                  ),
                },
                polylines: {
                  if (_path.isNotEmpty)
                    Polyline(
                      polylineId: const PolylineId("trackingPath"),
                      points: _path,
                      color: Colors.blue,
                      width: 5,
                    ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleTracking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.violetColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 15),
            if (!_isTracking && _path.isNotEmpty)
              Text("Total Distance: ${_totalDistance.toStringAsFixed(2)} meters", style: TextStyle(fontSize: 20),),

            Text("Elapsed Time: ${_elapsedSeconds ~/ 3600}:${(_elapsedSeconds % 3600) ~/ 60}:${_elapsedSeconds % 60}", style: TextStyle(fontSize: 20)),
            Text("Calories Burned: ${_caloriesBurned.toStringAsFixed(2)} kcal", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
