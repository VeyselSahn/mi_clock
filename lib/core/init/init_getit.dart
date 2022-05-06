import 'package:get_it/get_it.dart';
import 'package:mi_clock/core/service/alarm_service.dart';
import 'package:mi_clock/core/service/background_service.dart';
import 'package:mi_clock/core/service/cache_service.dart';

import '../service/navigator_service.dart';

var getIt = GetIt.instance;

void setUpLocators() {
  getIt.registerLazySingleton(() => CacheService());
  getIt.registerLazySingleton(() => NavigatorService());
  getIt.registerLazySingleton(() => AlarmService());
  getIt.registerLazySingleton(() => BackgroundService());
}
