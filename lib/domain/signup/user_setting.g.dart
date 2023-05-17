// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSetting _$UserSettingFromJson(Map<String, dynamic> json) => UserSetting(
      audioQuality: json['audio_quality'] as String? ?? 'Standard',
      isAutoDownload: json['is_auto_download'] as bool? ?? false,
      isBiometric: json['is_biometric'] as bool? ?? false,
      isDownloadWifi: json['is_download_wifi'] as bool? ?? true,
      isFaceId: json['is_faceid'] as bool? ?? false,
      isRemember: json['is_remember'] as bool? ?? true,
      isRemindBedtime: json['is_remind_bedtime'] as bool? ?? false,
      isSetReminder: json['is_set_reminder'] as bool? ?? false,
    );

Map<String, dynamic> _$UserSettingToJson(UserSetting instance) =>
    <String, dynamic>{
      'audio_quality': instance.audioQuality,
      'is_auto_download': instance.isAutoDownload,
      'is_biometric': instance.isBiometric,
      'is_download_wifi': instance.isDownloadWifi,
      'is_faceid': instance.isFaceId,
      'is_remember': instance.isRemember,
      'is_remind_bedtime': instance.isRemindBedtime,
      'is_set_reminder': instance.isSetReminder,
    };
