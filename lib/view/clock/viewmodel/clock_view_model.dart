import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mi_clock/component/ui/bottom_sheet.dart';
import 'package:mi_clock/view/clock/model/clock_model.dart';

class ClockViewModel extends ChangeNotifier {
  String clock = '00.00.00';
  String date = '';
  var clockFormatter = DateFormat(DateFormat.HOUR24_MINUTE_SECOND);
  var dateFormatter = DateFormat(DateFormat.YEAR_MONTH_DAY);
  List<ClockModel> clocks = [];

  void init() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () => changeTime(clockFormatter.format(DateTime.now()), dateFormatter.format(DateTime.now())),
    );
    init();
  }

  String returnSubtitle(int difference) {
    return (difference.isNegative
        ? difference.abs().toString() + ' hours behind'
        : difference.toString() + 'hours ahead');
  }

  changeTime(String newClock, String newDate) {
    date = newDate;
    clock = newClock;
    notifyListeners();
  }

  void addClock(ClockModel clock) {
    clocks.add(clock);
    notifyListeners();
  }

  final List<ClockModel> clockList = [
    ClockModel('London', 'England', 0),
    ClockModel('Sofia', 'Bulgaria', 3),
    ClockModel('Tokyo', 'Japan', 9)
  ];
  void showClocks() async {
    var _value = await showCustomBottomSheet(clockList.map((e) => e.cityName).toList());
    for (var clock in clockList) {
      if (_value == clock.cityName) {
        addClock(clock);
        break;
      }
    }
  }
}
