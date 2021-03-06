import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mi_clock/component/constant/hive_box_names.dart';
import 'package:mi_clock/component/constant/getit_const.dart';
import 'package:mi_clock/component/ui/bottom_sheet.dart';
import 'package:mi_clock/view/alarm/model/alarm_model.dart';
import 'package:mi_clock/view/alarm/view/add_alarm_screen.dart';

class AlarmViewModel extends ChangeNotifier {
  List<AlarmModel> alarms = [];

  void fillAlarms(List<AlarmModel> model) {
    alarms = model;
    notifyListeners();
  }

  void getAlarms() async {
    var _box = await GlobalVar.cacheService.openBox(HiveBoxNames.alarms);
    _box.listenable().addListener(() {
      Iterable _res = GlobalVar.cacheService.getAlarms(HiveBoxNames.alarms);
      fillAlarms(_res.toList() as List<AlarmModel>);
    });
    // for first filling
    Iterable _res = GlobalVar.cacheService.getAlarms(HiveBoxNames.alarms);
    fillAlarms(_res.toList() as List<AlarmModel>);
  }

  void changeActiveStatus(int index) async {
    var _box = await GlobalVar.cacheService.openBox(HiveBoxNames.alarms);
    var _nesne = _box.getAt(index)!;
    _nesne.isActive = !_nesne.isActive!;
    _nesne.save();
    notifyListeners();
  }

  void addAlarm() async {
    var _box = await GlobalVar.cacheService.openBox(HiveBoxNames.alarms);
    _box.add(tempModel);
    GlobalVar.navigatorService.navigatePop();
  }

  navigate() {
    GlobalVar.navigatorService.navigateTo(const AddAlarmScreen());
  }
  //for add screen

  static const ringtones = ['Default', 'Input', 'Circle'];
  static const repeads = ['Daily', 'Once', 'Monday to Friday'];
  static const label = ['Wake up', 'Time to awake', 'Last notice'];
  AlarmModel tempModel = AlarmModel(
      isActive: false,
      hour: DateTime.now().hour,
      minute: DateTime.now().minute,
      repeat: repeads.first,
      isVibrationActive: true,
      ringtone: ringtones.first,
      label: label.first);

  void changeStatus(dynamic newData, AlarmModelItems item) {
    switch (item) {
      case AlarmModelItems.isActive:
        tempModel.isActive = newData;
        break;
      case AlarmModelItems.label:
        tempModel.label = newData;
        break;
      case AlarmModelItems.ringtone:
        tempModel.ringtone = newData;
        break;
      case AlarmModelItems.repeat:
        tempModel.repeat = newData;
        break;
      case AlarmModelItems.hour:
        tempModel.hour = newData;
        break;
      case AlarmModelItems.minute:
        tempModel.minute = newData;
        break;
      case AlarmModelItems.isVibrationActive:
        tempModel.isVibrationActive = newData;
        break;
      default:
    }
    notifyListeners();
  }

  Future<void> bottomSheet(AlarmModelItems item) async {
    late List list;
    switch (item) {
      case AlarmModelItems.label:
        list = label;
        break;
      case AlarmModelItems.repeat:
        list = repeads;
        break;
      case AlarmModelItems.ringtone:
        list = ringtones;
        break;
      default:
    }
    var _value = '';
    _value = await showCustomBottomSheet(list);

    changeStatus(_value, item);
  }
}
