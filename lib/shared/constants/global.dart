import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? dateFromJson(Timestamp? val) => val == null
    ? null
    : DateTime.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch);

Timestamp? dateToJson(DateTime? time) => time == null
    ? null
    : Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);

String? validateMobile(String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value!=null && value.isEmpty) {
    return 'Please enter mobile number';
  }
  else if (!regExp.hasMatch(value!)) {
    return 'Please enter valid mobile number';
  }
  return null;
}