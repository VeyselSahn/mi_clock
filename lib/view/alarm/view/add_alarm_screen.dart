import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_clock/core/helper/extensions/size_extension.dart';
import 'package:numberpicker/numberpicker.dart';

class AddAlarmScreen extends StatelessWidget {
  const AddAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        'Add Alarm',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text('Alarm in 23 hours 59 minutes')
                    ],
                  ),
                  const Icon(
                    Icons.check,
                    size: 30,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            buildClockNumbers(context),
            const SizedBox(
              height: 20,
            ),
            tile('Ringtone', value: 'Default ringtone'),
            tile('Repeat', value: 'Once'),
            tile('Vibrate when alarm sounds', isSwitch: true),
            tile('Delete after goes off', isSwitch: true),
            tile('Label', value: '')
          ],
        ),
      ),
    );
  }

  Row buildClockNumbers(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 0,
        ),
        NumberPicker(
          minValue: 00,
          maxValue: 23,
          zeroPad: false,
          value: 12,
          itemCount: 5,
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 20),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
          infiniteLoop: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: context.height * .3,
          child: VerticalDivider(
            thickness: 1,
            color: Colors.grey.shade200,
          ),
        ),
        NumberPicker(
          minValue: 00,
          maxValue: 59,
          zeroPad: true,
          itemCount: 5,
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 20),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
          value: 12,
          infiniteLoop: true,
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 0,
        )
      ],
    );
  }

  Widget tile(String title, {String? value = '', bool? isSwitch = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          isSwitch!
              ? CupertinoSwitch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: Colors.blue,
                )
              : Row(
                  children: [
                    Text(value!, style: TextStyle(color: Colors.grey.shade600)),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey.shade600,
                    )
                  ],
                )
        ],
      ),
    );
  }
}
