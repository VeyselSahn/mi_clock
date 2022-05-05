import 'package:hive_flutter/hive_flutter.dart';
import 'package:mi_clock/view/alarm/model/alarm_model.dart';

class CacheService {
  Future<Box<AlarmModel>> openBox(String boxName) async {
    return (Hive.isBoxOpen(boxName) ? Hive.box<AlarmModel>(boxName) : await Hive.openBox<AlarmModel>(boxName));
  }

  void cacheAlarms(String boxName, AlarmModel alarm) async {
    var _box = Hive.box<AlarmModel>(boxName);
    await _box.add(alarm);
  }

  dynamic getAlarms(String boxName) {
    var _box = Hive.box<AlarmModel>(boxName);
    return _box.values;
  }

  dynamic cacheAllList(String boxName, List<String> lastStatus) async {
    var _box = Hive.box(boxName);
    await _box.clear();
    await _box.addAll(lastStatus);
  }
}
