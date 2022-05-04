import 'package:flutter/material.dart';
import 'package:mi_clock/view/chronometer/model/button_model.dart';
import 'package:mi_clock/view/chronometer/model/lap_model.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:intl/intl.dart';

class ChronometerViewModel extends ChangeNotifier {
  static final StopWatchTimer timer = StopWatchTimer(mode: StopWatchMode.countUp);
  String time = '00.00.00';
  List<LapModel> lapList = [];
  List<ButtonModel> buttons = [];
  final NumberFormat _formatter = NumberFormat("00");

  bool get haveElement => lapList.isNotEmpty;

  void _changeTime(String val) {
    time = val;
    notifyListeners();
  }

  String _display(int returnThis) => StopWatchTimer.getDisplayTime(
        returnThis,
        hours: false,
      );

  void changeLaps(List<StopWatchRecord> laps) {
    lapList.clear();
    for (int i = 0; i < laps.length; i++) {
      lapList.add(LapModel(_formatter.format(i + 1), _display(laps[i].rawValue ?? 0),
          i == 0 ? _display(laps[i].rawValue ?? 0) : _display((laps[i].rawValue ?? 0) - (laps[i - 1].rawValue ?? 0))));
    }
    notifyListeners();
  }

  void _changeButtons(List<ButtonModel> newButtons) {
    buttons = newButtons;
    notifyListeners();
  }

  init() {
    _listenTime();
    _listenTap();
    _listenButton();
    _changeButtons([_startButton]);
  }

  void _listenTime() {
    timer.rawTime.listen((event) {
      _changeTime(_display(event));
    });
  }

  void _listenTap() {
    timer.records.listen((event) {
      changeLaps(event);
    });
  }

  _listenButton() {
    timer.execute.listen((event) {
      switch (event) {
        case StopWatchExecute.start:
          _changeButtons([_lapButton, _stopButton]);
          break;
        case StopWatchExecute.stop:
          _changeButtons([_resetButton, _startButton]);
          break;
        case StopWatchExecute.reset:
          _changeButtons([_startButton]);
          break;
        default:
      }
    });
  }

  //const buttons
  final _startButton = ButtonModel(Icons.play_arrow, () => timer.onExecute.add(StopWatchExecute.start));
  final _stopButton = ButtonModel(Icons.pause, () => timer.onExecute.add(StopWatchExecute.stop));
  final _resetButton = ButtonModel(Icons.stop, () => timer.onExecute.add(StopWatchExecute.reset));
  final _lapButton = ButtonModel(Icons.flag, () => timer.onExecute.add(StopWatchExecute.lap));
}
