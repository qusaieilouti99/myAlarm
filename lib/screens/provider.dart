import 'package:flutter/material.dart';
import 'package:my_alarm/widgets/alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class AlarmApp extends ChangeNotifier {
  List<bool> values = List.filled(7, false);
  bool isChecked;
  DateTime time;
  bool dayNight = true;
  LinearGradient myColor = LinearGradient(colors: [Colors.black, Colors.black]);
  List<Alarm> alarms = [];

  void selectDay(int day) {
    for (int i = 0; i < values.length; i++) {}
    if (values[day % 7] == false)
      values[day % 7] = true;
    else
      values[day % 7] = false;
    notifyListeners();
  }

  String showDays() {
    String days = '';
    for (int i = 0; i < values.length; i++) {
      if (i == 0 && values[i] == true) days += 'Sun';
      if (i == 1 && values[i] == true) days += ' Mon';
      if (i == 2 && values[i] == true) days += ' Tue';
      if (i == 3 && values[i] == true) days += ' Wed';
      if (i == 4 && values[i] == true) days += ' Thu';
      if (i == 5 && values[i] == true) days += ' Fri';
      if (i == 6 && values[i] == true) days += ' Sat';
    }
    return days;
  }

  void checkBoxChange(value, int index) {
    alarms[index].isChecked = value;
    myColor = changeColor(index);
    notifyListeners();
  }

  DateTime getTime(DateTime dateTime) {
    time = dateTime;
    notifyListeners();
    return time;
  }

  LinearGradient changeColor(index) {
    if (alarms[index].isChecked) {
      return LinearGradient(
          colors: [Color(0xfff79901), Color(0xfff79901).withOpacity(0.4)]);
    } else
      return LinearGradient(colors: [Colors.black, Colors.black]);
  }

  void addAlarm(DateTime a) {
    final alarm =
        Alarm(time: a, isChecked: true, dayNight: dayNight, days: showDays());
    alarms.add(alarm);
    values = List.filled(7, false);
    notifyListeners();
  }

  bool changeDayNight(value) {
    dayNight = value;
    notifyListeners();
    return dayNight;
  }

  Future<void> scheduleAlarmNotif() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Amman'));
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'id', 'name', 'description',
      //icon: 'codex_logo',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
      priority: Priority.max,
      //largeIcon: DrawableResourceAndroidBitmap('codex_logo')
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'plain title',
        'plain body',
        tz.TZDateTime.from(time, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }
}
