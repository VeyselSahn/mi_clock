import 'package:flutter/material.dart';
import 'package:mi_clock/core/helper/extensions/size_extension.dart';
import 'package:mi_clock/view/clock/viewmodel/clock_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../../component/ui/button_widget.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClockViewModel>.reactive(
      viewModelBuilder: () => ClockViewModel(),
      onModelReady: (model) => model.init(),
      disposeViewModel: false,
      builder: (context, viewModel, child) => Stack(alignment: Alignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.clock,
                style: const TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w500),
              ),
              Text(
                'Current: ' + viewModel.date,
                style: const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 50,
              ),
              viewModel.clocks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.location_off, size: 30),
                          SizedBox(
                            height: 6,
                          ),
                          Text('No clocks here',
                              style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: context.height * .6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewModel.clocks.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(viewModel.clocks[index].cityName),
                            subtitle: Text(viewModel.returnSubtitle(viewModel.clocks[index].difference)),
                            leading: const Icon(Icons.alarm),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          child: GestureDetector(onTap: () => viewModel.showClocks(), child: ButtonWidget(icon: Icons.add)),
        ),
      ]),
    );
  }
}
