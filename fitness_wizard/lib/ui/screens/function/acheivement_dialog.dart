import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/achievement_data.dart';




class AchievementDialog extends StatelessWidget {
  AchievementDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final achievementData = Provider.of<AchievementData>(context);

    return AlertDialog(
      title: Text('Achievements'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildAchievementRow('First activity', achievementData.achievementsUnlocked[0], 'bronzelock.png', 'bronze.png'),
            _buildAchievementRow('Warm Up(Exercise 5 min)', achievementData.achievementsUnlocked[1], 'silverlock.png', 'silver.png'),
            _buildAchievementRow('First HR(Exercise 1 hr)', achievementData.achievementsUnlocked[2], 'goldlock.png', 'golden.png'),
            _buildAchievementRow('First KM(Exercise 1 km)', achievementData.achievementsUnlocked[3], 'last-lock.png', 'lastmedal.png'),
            _buildAchievementRow('Long Distance(Exercise 10 km)', achievementData.achievementsUnlocked[4], 'bluelock.png', 'blue.jpg'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildAchievementRow(String title, bool unlocked, String bwImage, String colorImage) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/images/${unlocked ? colorImage : bwImage}',
          width: 50,
          height: 50,
        ),
        const SizedBox(width: 10),
        Text(title),
      ],
    );
  }
}
