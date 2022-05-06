import 'package:mi_clock/core/init/init_getit.dart';
import 'package:mi_clock/core/service/alarm_service.dart';
import 'package:mi_clock/core/service/background_service.dart';
import 'package:mi_clock/core/service/navigator_service.dart';

import '../../core/service/cache_service.dart';

class GlobalVar {
  static var cacheService = getIt<CacheService>();
  static var navigatorService = getIt<NavigatorService>();
  static var alarmService = getIt<AlarmService>();
  static var context = getIt<NavigatorService>().navigatorKey.currentContext;
  static var backgroundService = getIt<BackgroundService>();
}
