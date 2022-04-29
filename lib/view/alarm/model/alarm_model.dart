class AlarmModel {
  bool? isActive;
  DateTime? time;
  String? repeat;
  String? label;
  bool? isVibrationActive;
  String? ringtone;

  AlarmModel(
      {required this.isActive,
      required this.time,
      required this.repeat,
      this.label = '',
      this.isVibrationActive = false,
      this.ringtone = ''});
}

List<AlarmModel> list = [
  AlarmModel(isActive: true, time: DateTime.now(), repeat: 'Daily'),
  AlarmModel(isActive: false, time: DateTime.now(), repeat: 'Once')
];
