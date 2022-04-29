// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_clock/view/alarm/model/alarm_model.dart';
import 'package:mi_clock/view/alarm/view/add_alarm_screen.dart';

class AlarmScreen extends ConsumerWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView.builder(
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
              child: ListTile(
                title: Text(list[index].time!.hour.toString() + ':' + list[index].time!.minute.toString()),
                subtitle: Text(
                  list[index].repeat! + ' | ' + 'Alarm in 23 hours 59 minutes',
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: CupertinoSwitch(
                    value: list[index].isActive!,
                    onChanged: (val) => list[index].isActive = val,
                    activeColor: Colors.blue),
              ),
            );
          },
        ),
        Positioned(
            bottom: 50,
            height: 70,
            width: 70,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              child: IconButton(
                icon: const Icon(Icons.add, size: 30, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddAlarmScreen(),
                      ));
                },
              ),
            ))
      ],
    );
  }
}
