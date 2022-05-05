import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mi_clock/component/ui/bottom_sheet.dart';

class TimerViewModel extends ChangeNotifier {
  int hour = 0;
  int minute = 0;
  int second = 0;
  final NumberFormat formatter = NumberFormat('00');

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

  reset() {
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
      reset();
      changeTime(_int ?? 0, TimerItem.minute);
    } else {
      reset();
      changeTime(01, TimerItem.hour);
    }
  }

  void startTimer() async {
    var _time = DateTime.now().add(Duration(hours: hour, minutes: minute, seconds: second));
  }

  void cancel() async {}
}

enum TimerItem { hour, minute, second }
