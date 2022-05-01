import 'package:flutter/material.dart';
import 'package:mi_clock/component/ui/button_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

final StopWatchTimer timer = StopWatchTimer(
  mode: StopWatchMode.countUp,
);

class ChronometerScreen extends StatelessWidget {
  const ChronometerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder<int>(
              stream: timer.rawTime,
              initialData: 0,
              builder: (context, snapshot) {
                final value = snapshot.data;
                final display = StopWatchTimer.getDisplayTime(value!, hours: false);
                return Center(
                  child: Text(display, style: const TextStyle(fontSize: 70)),
                );
              }),
          const SizedBox(
            height: 0,
          )
        ],
      ),
      Positioned(
          bottom: 40,
          child: Row(
            children: const [
              ButtonWidget(icon: Icons.stop),
              SizedBox(
                width: 40,
              ),
              ButtonWidget(icon: Icons.play_arrow)
            ],
          ))
    ]);
  }
}
