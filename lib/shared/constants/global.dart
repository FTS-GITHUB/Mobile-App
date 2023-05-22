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

Future<void> deletePreviousSession(String id) async {
  restartTimer();
  await localDatabaseService.delete(id);
}

int get sessionInMinutes {
  Duration sessionDuration = stopWatch.elapsedDuration as Duration;
  int sessionDurationInMinutes = sessionDuration.inMinutes;
  return sessionDurationInMinutes;
}

Duration durationParse(String time) {
  final ts = DateFormat('y-MM-dd').format(DateTime.now());
  final dt = DateTime.parse('$ts $time');
  return Duration(hours: dt.hour, minutes: dt.minute, seconds: dt.second);
}

int countCurrentStreak(List<DateTime> dates) {
  int consecutiveDays = 0;
  DateTime today = dates.last;

  for (int i = dates.length - 1; i >= 0; i--) {
    if (isSameDate(dates[i], today)) {
      consecutiveDays++;
      today = today.subtract(
        const Duration(days: 1),
      );
    } else {
      break;
    }
  }

  return consecutiveDays;
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

int countLongestStreak(List<DateTime> dates) {
  int consecutiveDays = 0;
  int currentConsecutiveDays = 0;

  for (int i = 0; i < dates.length - 1; i++) {
    DateTime currentDate = dates[i];
    DateTime nextDate = dates[i + 1];

    if (isConsecutiveDate(currentDate, nextDate)) {
      currentConsecutiveDays++;
    } else {
      currentConsecutiveDays = 0;
    }

    if (currentConsecutiveDays > consecutiveDays) {
      consecutiveDays = currentConsecutiveDays;
    }
  }

  return consecutiveDays + 1;
}

bool isConsecutiveDate(DateTime date1, DateTime date2) {
  final difference = date2.difference(date1).inDays;
  return difference == 1;
}

