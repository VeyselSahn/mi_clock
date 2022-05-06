import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:intl/intl.dart';
import 'package:schedulers/schedulers.dart';

class BackgroundService {
  Future initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will executed when app is in foreground or background in separated isolate
        onStart: onStart,
        // auto start service
        autoStart: false,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: false,
        // this will executed when app is in foreground in separated isolate
        onForeground: onStart,
        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
  bool onIosBackground(ServiceInstance service) {
    WidgetsFlutterBinding.ensureInitialized();

    return true;
  }

  void onStart(ServiceInstance service) async {
    final scheduler = TimeScheduler();
    final formatter = DateFormat(DateFormat.HOUR24_MINUTE_SECOND);

    if (service is AndroidServiceInstance) {
      service.on('front').listen((event) {
        service.setAsForegroundService();
      });

      service.on('back').listen((event) {
        service.setAsBackgroundService();
      });

      service.on('timer').listen((event) {
        var _parsed = DateTime.tryParse(event?['time']);
        service.setForegroundNotificationInfo(
            title: formatter.format(_parsed ?? DateTime.now()), content: event?['text'] ?? '');
        // ignore: avoid_print
        scheduler.run(() => print('evet'), _parsed ?? DateTime.now()).result.then((value) => service.stopSelf());
      });

      service.on('stop').listen((event) {
        service.stopSelf();
      });
    }
  }
}
