// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String timeAgo({bool numericDates = true}) {
    String val = '';
    if(this!=null){
      final DateTime date2 = DateTime.now();
      final Duration difference = date2.difference(this!);
      if (difference.inDays >= 1 && difference.inDays<=31) {
        val= '${difference.inDays} Days Ago';
      }else if (difference.inDays >= 30 && difference.inDays<=60) {
      val= 'A Month Ago';
    }else if (difference.inDays >= 60 && difference.inDays<=90) {
        val= 'Two Months Ago';
      }else if (difference.inDays >= 365) {
      val= 'Year ago';
    }
      else if ((difference.inDays / 7).floor() >= 1) {
        val= (numericDates) ? '1 week ago' : 'Last week';
      }  else {
        val = 'Today';
      }
    }
    return val;
  }

  String toMonthDateYear() {
    String date='';
    if(this!=null){
      date = DateFormat('MMM dd, yyyy').format(this!);
    }
    return date;
  }

  String toDateMonthYear() {
    String date='';
    if(this!=null){
      date = DateFormat('dd/MM/yyyy').format(this!);
    }
    return date;
  }

  bool areDaysEqual({required DateTime to}) {
    bool flag = false;
    if(this!=null){
      DateTime from = DateTime(this!.year, this!.month, this!.day);
      to = DateTime(to.year, to.month, to.day);
      if (from == to) {
        flag= true;
      } else {
        flag = false;
      }
    }
    return flag;

  }
}
