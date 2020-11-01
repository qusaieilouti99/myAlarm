import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_alarm/screens/AddAlarm.dart';
import 'alarsmScreen.dart';
import 'homeScreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xfff79901),
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddAlarm(),
                ),
              ),
            );
          },
        ),
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(50, 50),
            child: TabBar(
              labelColor: Color(0xfff79901),
              unselectedLabelColor: Colors.black,
              indicatorColor: Color(0xfff79901),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 35,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.access_alarm,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          elevation: 5,
          backgroundColor: Color(0xff111111),
          toolbarHeight: 120,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MY',
                style: GoogleFonts.mitr(
                  fontWeight: FontWeight.w300,
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: Color(0xff999999),
                  ),
                ),
              ),
              Text(
                ' ALARM',
                style: GoogleFonts.mitr(
                  fontWeight: FontWeight.w300,
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: Color(0xfff79901),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          child: TabBarView(
            children: [
              HomeScreen(),
              AlarmsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
