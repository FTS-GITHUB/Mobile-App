// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String?,
      appUseDuration: json['app_use_duration'] as String?,
      sessionDate: json['session_date'] as int?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'app_use_duration': instance.appUseDuration,
      'session_date': instance.sessionDate,
    };
