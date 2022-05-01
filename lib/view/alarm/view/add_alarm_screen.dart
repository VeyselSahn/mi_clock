import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_clock/component/constant/getit_const.dart';
import 'package:mi_clock/core/helper/extensions/size_extension.dart';
import 'package:mi_clock/view/alarm/model/alarm_model.dart';
import 'package:mi_clock/view/alarm/viewmodel/alarm_view_model.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class AddAlarmScreen extends StatelessWidget {
  const AddAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AlarmViewModel>.reactive(
      viewModelBuilder: () => AlarmViewModel(),
      builder: (context, viewModel, child) => Scaffold(
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
                    GestureDetector(
                      onTap: () => viewModel.addAlarm(),
                      child: const Icon(
                        Icons.check,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildClockNumbers(context, viewModel),
              const SizedBox(
                height: 20,
              ),
              tile('Ringtone', AlarmModelItems.ringtone, viewModel: viewModel, value: viewModel.tempModel.ringtone),
              tile('Repeat', AlarmModelItems.repeat, viewModel: viewModel, value: viewModel.tempModel.repeat),
              tile('Vibrate when alarm sounds', AlarmModelItems.isVibrationActive,
                  viewModel: viewModel, value: viewModel.tempModel.isVibrationActive, isSwitch: true),
              tile('Delete after goes off', AlarmModelItems.isVibrationActive,
                  viewModel: viewModel, value: false, isSwitch: true),
              tile(
                'Label',
                AlarmModelItems.label,
                viewModel: viewModel,
                value: viewModel.tempModel.label,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildClockNumbers(BuildContext context, AlarmViewModel viewModel) {
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
          value: viewModel.tempModel.hour!,
          itemCount: 5,
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 20),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
          infiniteLoop: true,
          onChanged: (value) {
            viewModel.changeStatus(value, AlarmModelItems.hour);
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
          textStyle: TextStyle(color: Colors.grey.shade500, fontSize: 20),
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
          value: viewModel.tempModel.minute,
          infiniteLoop: true,
          onChanged: (value) {
            viewModel.changeStatus(value, AlarmModelItems.minute);
          },
        ),
        const SizedBox(
          height: 0,
        )
      ],
    );
  }

  Widget tile(
    String title,
    AlarmModelItems item, {
    required AlarmViewModel viewModel,
    required dynamic value,
    bool? isSwitch = false,
  }) {
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
                  value: value!,
                  onChanged: (val) {
                    viewModel.changeStatus(val, item);
                  },
                  activeColor: Colors.blue,
                )
              : GestureDetector(
                  onTap: () {
                    viewModel.bottomSheet(item);
                  },
                  child: Row(
                    children: [
                      Text(value!, style: TextStyle(color: Colors.grey.shade600)),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey.shade600,
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
