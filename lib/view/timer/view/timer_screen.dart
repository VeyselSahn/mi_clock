import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_clock/component/ui/button_widget.dart';
import 'package:mi_clock/core/helper/extensions/size_extension.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildClockNumbers(context),
          const SizedBox(
            height: 0,
          ),
        ],
      ),
      Positioned(
          bottom: 40,
          width: context.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SmallButtonWidget(icon: Icons.music_note),
              ButtonWidget(icon: Icons.play_arrow),
              SmallButtonWidget(
                icon: Icons.density_medium_rounded,
              )
            ],
          )),
    ]);
  }

  Row buildClockNumbers(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NumberPicker(
          minValue: 00,
          maxValue: 23,
          zeroPad: false,
          value: 11,
          itemCount: 5,
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 25),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 40),
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
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 25),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 40),
          value: 34,
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
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 25),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 40),
          value: 59,
          infiniteLoop: true,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
