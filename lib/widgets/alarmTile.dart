import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:my_alarm/screens/provider.dart';
import 'package:provider/provider.dart';

class AlarmTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmApp>(
      builder: (BuildContext context, alarmProvider, Widget child) {
        return ListView.builder(
          itemCount: alarmProvider.alarms.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(.2))),
                gradient: alarmProvider.changeColor(index),
              ),
              padding: EdgeInsets.all(20),
              child: SwitchListTile(
                activeColor: Color(0xfff79901),
                title: Text(
                  alarmProvider.alarms[index].days,
                ),
                secondary: Text(
                  DateFormat.jm()
                      .format(alarmProvider.alarms[index].time)
                      .substring(0, 5),
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  DateFormat.jm()
                      .format(alarmProvider.alarms[index].time)
                      .substring(5),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onChanged: (bool value) =>
                    alarmProvider.checkBoxChange(value, index),
                value: alarmProvider.alarms[index].isChecked,
              ),
            );
          },
        );
      },
    );
  }
}
