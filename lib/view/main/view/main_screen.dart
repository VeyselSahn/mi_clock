import 'package:flutter/material.dart';
import 'package:mi_clock/view/alarm/view/alarm_screen.dart';
import 'package:mi_clock/view/chronometer/view/chronometer_screen.dart';
import 'package:mi_clock/view/clock/view/clock_screen.dart';
import 'package:mi_clock/view/timer/view/timer_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeData().scaffoldBackgroundColor,
            title: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(
                    height: 0,
                  ),
                  TabBar(
                    unselectedLabelColor: Colors.grey,
                    enableFeedback: false,
                    labelColor: Colors.blue,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.alarm),
                      ),
                      Tab(
                        icon: Icon(Icons.schedule),
                      ),
                      Tab(
                        icon: Icon(Icons.timer_outlined),
                      ),
                      Tab(
                        icon: Icon(Icons.access_time),
                      )
                    ],
                  ),
                  Icon(Icons.menu, color: Colors.black),
                ],
              ),
            ),
          ),
          body: const TabBarView(children: [AlarmScreen(), ClockScreen(), ChronometerScreen(), TimerScreen()])),
    );
  }
}
