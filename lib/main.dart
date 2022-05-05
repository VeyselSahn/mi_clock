import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mi_clock/component/constant/getit_const.dart';
import 'package:mi_clock/core/init/init_getit.dart';
import 'package:mi_clock/view/alarm/model/alarm_model.dart';
import 'package:mi_clock/view/alarm/viewmodel/alarm_view_model.dart';
import 'package:mi_clock/view/main/view/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmModelAdapter());
  // TimerService().initializeService();
  await AndroidAlarmManager.initialize();

  setUpLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AlarmViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'Mi Clock',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: GlobalVar.navigatorService.navigatorKey,
        home: const MainScreen(),
      ),
    );
  }
}
