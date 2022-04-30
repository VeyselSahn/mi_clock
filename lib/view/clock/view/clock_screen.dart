import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/ui/button_widget.dart';

class ClockScreen extends ConsumerWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list = [];
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '11:13:35',
              style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const Text(
              'Current: 30/04/2022',
              style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.normal),
            ),
            Expanded(
              child: list.isEmpty
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
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Alarm $index'),
                          trailing: const Icon(Icons.alarm),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
      const Positioned(
        bottom: 40,
        child: ButtonWidget(icon: Icons.add),
      ),
    ]);
  }
}
