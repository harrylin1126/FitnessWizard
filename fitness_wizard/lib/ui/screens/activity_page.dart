import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/distance_data.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  double _targetDistance = 5269.0; //
  double _calculateCalories(double distance) {
    double userWeight = 70.0;
    double distanceInKm = distance / 1000;
    return distanceInKm * userWeight * 1.036;
  }

  @override
  Widget build(BuildContext context) {
    final totalDistance = Provider.of<DistanceData>(context).totalDistance;
    final caloriesBurned = _calculateCalories(totalDistance);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // 點擊框框後彈出對話框輸入目標距離
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('設定目標距離'),
                content: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _targetDistance = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('確定'),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            // 將整個框框包裝起來
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple[200], // 使用紫羅蘭色
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // 改變陰影的位置
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 圖表顯示
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 75.0,
                        height: 75.0,
                        child: CircularProgressIndicator(
                          value: totalDistance / _targetDistance,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple[300]!), // 使圖表的顏色更深一點
                        ),
                      ),
                      // 中心顯示完成百分比
                      Text(
                        '${(totalDistance / _targetDistance * 100).toInt()}%',
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      // 獎盃 Icon
                      if (totalDistance >= _targetDistance)
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3), // 改變陰影的位置
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              size: 40.0,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                    ],
                  ),
                  // 目標距離和百分比
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // 圖表外部右側顯示目標距離
                      Text(
                        '$totalDistance/$_targetDistance',
                        style: const TextStyle(fontSize: 16.0, color: Colors.white), // 將文字顏色改為白色
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple[200], // 使用紫羅蘭色
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // 改變陰影的位置
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 第一个框框
                  Container(
                    child: Icon(Icons.directions_run),
                  ),
                  // 圖表外部右側顯示目標距離
                  Text(
                    'Total Distance: ${totalDistance.toStringAsFixed(2)} meters',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple[200], // 使用紫羅蘭色
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // 改變陰影的位置
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 第二个框框
                  Container(
                    child: Icon(Icons.local_fire_department),
                  ),
                  // 圖表外部右側顯示目標距離
                  Text(
                    'Calories Burned: ${caloriesBurned.toStringAsFixed(2)} kcal',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
