import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mi_clock/component/ui/button_widget.dart';
import 'package:mi_clock/view/chronometer/model/lap_model.dart';
import 'package:mi_clock/view/chronometer/viewmodel/chronometer_view_mdoel.dart';
import 'package:stacked/stacked.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChronometerScreen extends StatefulWidget {
  const ChronometerScreen({Key? key}) : super(key: key);

  @override
  State<ChronometerScreen> createState() => _ChronometerScreenState();
}

class _ChronometerScreenState extends State<ChronometerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChronometerViewModel>.reactive(
      viewModelBuilder: () => ChronometerViewModel(),
      disposeViewModel: false,
      key: const Key('chrono'),
      onModelReady: (model) => model.init(),
      // ignore: avoid_print
      onDispose: (model) => print('dispose chrono'),
      builder: (context, viewModel, child) => Stack(alignment: Alignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: viewModel.haveElement ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisAlignment: viewModel.haveElement ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
            children: [
              Text(viewModel.time,
                  style: viewModel.haveElement ? const TextStyle(fontSize: 40) : const TextStyle(fontSize: 70)),
              const SizedBox(
                height: 8,
              ),
              viewModel.haveElement
                  ? const Text(
                      'Current timing',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              const SizedBox(
                height: 40,
              ),
              viewModel.lapList.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 300,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: viewModel.lapList.length,
                          itemBuilder: (context, index) => lapTile(viewModel.lapList[index]))),
            ],
          ),
        ),
        Positioned(
            bottom: 40,
            child: Row(
                children: List.generate(
                    viewModel.buttons.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                              onTap: () => viewModel.buttons[index].func(),
                              child: ButtonWidget(icon: viewModel.buttons[index].icon)),
                        ))))
      ]),
    );
  }

  Row lapTile(LapModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.flag,
                color: Colors.grey.shade500,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                model.index,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              )
            ],
          ),
        ),
        Text('+ ' + model.range, style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
        Text(
          model.time,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
