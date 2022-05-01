import 'package:hive_flutter/adapters.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class AlarmModel extends HiveObject {
  @HiveField(1)
  bool? isActive;
  @HiveField(2)
  int? hour;
  @HiveField(3)
  int minute;
  @HiveField(4)
  String? repeat;
  @HiveField(5)
  String? label;
  @HiveField(6)
  bool? isVibrationActive;
  @HiveField(7)
  String? ringtone;

  AlarmModel(
      {required this.isActive,
      required this.hour,
      required this.minute,
      required this.repeat,
      this.label = '',
      this.isVibrationActive = false,
      this.ringtone = ''});

  factory AlarmModel.fromJson(Map<String, dynamic>? json) {
    return AlarmModel(
        isActive: json?['isActive'] ?? false,
        hour: json?['hour'] ?? 01,
        minute: json?['minute'] ?? 01,
        repeat: json?['repeat'] ?? '',
        ringtone: json?['ringtone'] ?? '',
        label: json?['label'] ?? '',
        isVibrationActive: json?['isVibrationActive'] ?? false);
  }
  Map<String, dynamic> toJson() {
    return {
      "isActive": isActive,
      "hour": hour,
      "minute": minute,
      "repeat": repeat,
      "label": label,
      "isVibrationActive": isVibrationActive,
      "ringtone": ringtone
    };
  }
}

enum AlarmModelItems { isActive, hour, minute, repeat, label, isVibrationActive, ringtone }
