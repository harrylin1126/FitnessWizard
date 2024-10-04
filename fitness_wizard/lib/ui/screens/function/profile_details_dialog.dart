import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetailsDialog extends StatefulWidget {
  const ProfileDetailsDialog({super.key});

  @override
  State<ProfileDetailsDialog> createState() => _ProfileDetailsDialogState();
}
class _ProfileDetailsDialogState extends State<ProfileDetailsDialog> {
  double _height = 170;
  double _weight = 60;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // 返回按钮
            },
            child: const Icon(Icons.close, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text(
            'Height:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            initialValue: _height.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _height = double.tryParse(value) ?? _height;
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Weight:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            initialValue: _weight.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _weight = double.tryParse(value) ?? _weight;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'BMI: ${(_weight / ((_height / 100) * (_height / 100))).toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}