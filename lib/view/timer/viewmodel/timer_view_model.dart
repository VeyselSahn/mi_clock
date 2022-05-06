import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';
import 'package:mi_clock/component/constant/getit_const.dart';
import 'package:mi_clock/component/ui/bottom_sheet.dart';

class TimerViewModel extends ChangeNotifier {
  int hour = 0;
  int minute = 0;
  int second = 0;
  final NumberFormat formatter = NumberFormat('00');
  bool isRunning = false;

  changeIsRunning(bool newIsRunning) {
    isRunning = newIsRunning;
    notifyListeners();
  }

  changeTime(int llbe, TimerItem item) {
    switch (item) {
      case TimerItem.hour:
        hour = llbe;
        break;
      case TimerItem.minute:
        minute = llbe;
        break;
      case TimerItem.second:
        second = llbe;
        break;
      default:
    }
    notifyListeners();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 1),
        () => FlutterBackgroundService().isRunning().then((value) => changeIsRunning(value)));
    init();
  }

  _reset() {
    hour = 0;
    minute = 0;
    second = 0;
  }

  String format(String old) {
    return formatter.format(int.tryParse(old) ?? 0);
  }

  void menuIcon() async {
    List _list = ['15 mins', '30 mins', '60 mins'];
    var _val = '';
    _val = await showCustomBottomSheet(_list);
    var _cleaned = _val.replaceAll(r'mins', r'').replaceAll(r' ', r'');
    var _int = int.tryParse(_cleaned);
    if ((_int ?? 0) != 60) {
      _reset();
      changeTime(_int ?? 0, TimerItem.minute);
    } else {
      _reset();
      changeTime(01, TimerItem.hour);
    }
  }

  Future startTimer() async {
    var _time = DateTime.now().add(Duration(hours: hour, minutes: minute, seconds: second));
    final service = FlutterBackgroundService();
    await GlobalVar.backgroundService.initializeService();
    //temproray ,notf not working
    await Future.delayed(const Duration(seconds: 10));
    service.invoke('timer', {"time": _time.toString(), "text": "Is running"});
    changeIsRunning(true);
  }

  void cancel() async {
    final _service = FlutterBackgroundService();
    _service.invoke('stop');
    changeIsRunning(false);
  }
}

enum TimerItem { hour, minute, second }
