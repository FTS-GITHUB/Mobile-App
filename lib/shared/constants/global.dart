import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/infrastructure/services/local_database_service.dart';
import 'package:dropandgouser/shared/constants/stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime? dateFromJson(Timestamp? val) => val == null
    ? null
    : DateTime.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch);

Timestamp? dateToJson(DateTime? time) => time == null
    ? null
    : Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);

late LocalDatabaseService localDatabaseService;

String? validateMobile(String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value != null && value.isEmpty) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value!)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

bool isValidTimeRange(TimeOfDay startTime, TimeOfDay endTime) {
  DateTime now = DateTime.now();
  return ((now.hour > startTime.hour) ||
          (now.hour == startTime.hour && now.minute >= startTime.minute)) &&
      ((now.hour < endTime.hour) ||
          (now.hour == endTime.hour && now.minute <= endTime.minute));
}

StopWatchCustom stopWatch = StopWatchCustom();

DateTime now = DateTime.now();

DateTime sessionDate = DateTime(
  now.year,
  now.month,
  now.day,
);

restartTimer() {
  stopWatch.reset();
  stopWatch.start();
}

String formatDurationInHhMmSs(Duration duration) {
  final HH = (duration.inHours).toString().padLeft(2, '0');
  final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

  return '$HH:$mm:$ss';
}

Future<void> deletePreviousSession()async{
  restartTimer();
  await localDatabaseService.delete(DateTime(
    now.year,
    now.month,
    now.day-1,
  ).millisecondsSinceEpoch.toString());
}

int get sessionInMinutes{
  Duration sessionDuration = stopWatch.elapsedDuration as Duration;
  int sessionDurationInMinutes = sessionDuration.inMinutes;
  return sessionDurationInMinutes;
}

Duration durationParse(String time) {
  final ts = DateFormat('y-MM-dd').format(DateTime.now());
  final dt = DateTime.parse('$ts $time');
  return Duration(hours: dt.hour, minutes: dt.minute, seconds: dt.second);
}
