import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/onboarding_screen.dart';
import 'providers/achievement_data.dart';
import 'providers/distance_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AchievementData()),
        ChangeNotifierProvider(create: (context) => DistanceData()),
      ],
      child: MaterialApp(
        title: 'Fitness Wizard',
        theme: ThemeData.light(),
        home: const OnboardingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
