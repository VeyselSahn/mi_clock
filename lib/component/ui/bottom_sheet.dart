import 'package:flutter/material.dart';

import '../constant/getit_const.dart';

Future<String> showCustomBottomSheet(List list) async {
  String _value = '';
  await showModalBottomSheet(
      context: GlobalVar.context!,
      builder: (context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              list.length,
              (index) => ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(list.elementAt(index)),
                onTap: () {
                  _value = list[index];
                  Navigator.pop(context);
                },
              ),
            ));
      });
  return _value;
}
