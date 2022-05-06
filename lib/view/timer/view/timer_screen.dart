import 'package:flutter/material.dart';
import 'package:mi_clock/component/ui/button_widget.dart';
import 'package:mi_clock/core/helper/extensions/size_extension.dart';
import 'package:mi_clock/view/timer/viewmodel/timer_view_model.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stacked/stacked.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimerViewModel>.reactive(
      viewModelBuilder: () => TimerViewModel(),
      onModelReady: (model) => model.init(),
      disposeViewModel: false,
      builder: (context, viewModel, child) => Stack(
          alignment: Alignment.center,
          children: viewModel.isRunning
              ? runningWidget(viewModel)
              : [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildClockNumbers(context, viewModel),
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
                        children: [
                          const SmallButtonWidget(icon: Icons.music_note),
                          GestureDetector(
                              onTap: () async => await viewModel.startTimer(),
                              child: const ButtonWidget(icon: Icons.play_arrow)),
                          GestureDetector(
                            onTap: () => viewModel.menuIcon(),
                            child: const SmallButtonWidget(
                              icon: Icons.density_medium_rounded,
                            ),
                          )
                        ],
                      )),
                ]),
    );
  }

  List<Widget> runningWidget(TimerViewModel viewModel) {
    return [
      const Text('Running'),
      Positioned(
        bottom: 40,
        child: GestureDetector(onTap: () => viewModel.cancel(), child: const ButtonWidget(icon: Icons.stop)),
      )
    ];
  }

  Row buildClockNumbers(BuildContext context, TimerViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NumberPicker(
          minValue: 00,
          maxValue: 23,
          zeroPad: false,
          value: viewModel.hour,
          itemCount: 5,
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 25),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 40),
          infiniteLoop: true,
          textMapper: (val) => viewModel.format(val),
          onChanged: (value) {
            viewModel.changeTime(value, TimerItem.hour);
          },
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
          value: viewModel.minute,
          infiniteLoop: true,
          onChanged: (value) {
            viewModel.changeTime(value, TimerItem.minute);
          },
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
          value: viewModel.second,
          infiniteLoop: true,
          onChanged: (value) {
            viewModel.changeTime(value, TimerItem.second);
          },
        ),
      ],
    );
  }
}
