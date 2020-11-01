import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_alarm/screens/provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String formattedHour = DateFormat.jm().format(DateTime.now()).substring(0, 5);
  String formattedDay = DateFormat('EEE, d MMM').format(DateTime.now());
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        formattedHour = DateFormat.jm().format(DateTime.now()).substring(0, 5);
        formattedDay = DateFormat('EEE, d MMM').format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5),
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Consumer<AlarmApp>(
                builder: (BuildContext context, alarmProvider, Widget child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          formattedHour,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          formattedDay,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        child: Transform.rotate(
                          angle: -pi / 2,
                          child: CustomPaint(
                            painter: ClockPainter(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  DateTime dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var fillBrush = Paint()..color = Color(0xff111111);
    var outLineBrush = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..color = Colors.white;
    var centerBrush = Paint()
      ..strokeWidth = 5
      ..color = Colors.white;
    var secHandBrush = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.white;
    var minHandBrush = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..shader = RadialGradient(colors: [Color(0xfff79901), Color(0xfff79901)])
          .createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ))
      ..strokeCap = StrokeCap.round;
    var hourHandBrush = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..shader = RadialGradient(colors: [Color(0xfff79901), Color(0xfff79901)])
          .createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ))
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, fillBrush);
    canvas.drawCircle(center, radius, outLineBrush);
    //60sec - 360, 1 sec - 6degrees
    //60min - 360, 1 min - 6degrees
    //12hours - 360, 1 hour - 30degrees, 60min - 30degrees, 1 min - 0.5degrees
    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);
    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
    canvas.drawCircle(center, 5, centerBrush);
    var drawRush = Paint()..color = Colors.white;
    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 18;
    for (var i = 0; i < 360; i += 30) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), drawRush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
