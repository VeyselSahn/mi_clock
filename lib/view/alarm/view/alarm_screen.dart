// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_clock/component/ui/button_widget.dart';
import 'package:mi_clock/view/alarm/viewmodel/alarm_view_model.dart';
import 'package:stacked/stacked.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AlarmViewModel>.reactive(
      viewModelBuilder: () => AlarmViewModel(),
      onModelReady: (_model) => _model.getAlarms(),
      onDispose: (model) => print('onDispose'),
      builder: (context, model, child) => Stack(
        alignment: Alignment.topCenter,
        children: [
          ListView.builder(
            itemCount: model.alarms.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                child: ListTile(
                  title: Text(model.alarms[index].hour.toString() + ':' + model.alarms[index].minute.toString()),
                  subtitle: Text(
                    model.alarms[index].repeat! + ' | ' + 'Alarm in 23 hours 59 minutes',
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: CupertinoSwitch(
                      value: model.alarms[index].isActive!,
                      onChanged: (val) => model.changeActiveStatus(index),
                      activeColor: Colors.blue),
                ),
              );
            },
          ),
          Positioned(
              bottom: 40,
              child: GestureDetector(onTap: () => model.navigate(), child: const ButtonWidget(icon: Icons.add)))
        ],
      ),
    );
  }
}
