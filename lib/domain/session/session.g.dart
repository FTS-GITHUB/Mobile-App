// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String?,
      appUseDuration: json['app_use_duration'] as String?,
      sessionDate: json['session_date'] as int?,
      isSessionCompleted: json['isSessionCompleted'] as bool? ?? true,
    );

Map<String, dynamic> _$SessionToJson(Session instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['app_use_duration'] = instance.appUseDuration;
  val['session_date'] = instance.sessionDate;
  val['isSessionCompleted'] = instance.isSessionCompleted;
  return val;
}
