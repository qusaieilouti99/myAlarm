import 'package:flutter/material.dart';
import 'package:my_alarm/widgets/alarmTile.dart';

class AlarmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: AlarmTile(),
      ),
    );
  }
}
