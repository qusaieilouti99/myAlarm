import 'dart:ui';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_alarm/screens/provider.dart';
import 'package:provider/provider.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime _time = DateTime.now();
    return Consumer<AlarmApp>(
        builder: (BuildContext context, alarmProvider, Widget child) {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xff111111),
          boxShadow: [
            BoxShadow(
              color: Color(0xff999999).withOpacity(0.2),
              spreadRadius: 7,
              blurRadius: 7,
              offset: Offset(0, -3), // changes position of shadow
            ),
          ],
        ),
        height: 450,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle:
                  TextStyle(fontSize: 20, color: Colors.grey.withOpacity(.4)),
              highlightedTextStyle:
                  TextStyle(fontSize: 27, color: Colors.white),
              spacing: 50,
              itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                _time = alarmProvider.getTime(time);
              },
            ),
            SizedBox(
              height: 20,
            ),
            WeekdaySelector(
              selectedFillColor: Color(0xfff79901),
              onChanged: (int day) {
                alarmProvider.selectDay(day);
              },
              values: alarmProvider.values,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff79901),
                border: Border.all(),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: FlatButton(
                minWidth: 300,
                height: 50,
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  alarmProvider.addAlarm(_time);
                  await alarmProvider.scheduleAlarmNotif();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
