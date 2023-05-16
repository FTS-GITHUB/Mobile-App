import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_setting.g.dart';

@JsonSerializable(
  createToJson: true,
)
class UserSetting {
  UserSetting({
    this.audioQuality = 'Standard',
    this.isAutoDownload = false,
    this.isBiometric = false,
    this.isDownloadWifi = true,
    this.isFaceId = false,
    this.isRemember = true,
    this.isRemindBedtime = false,
    this.isSetReminder = false,
  });

  @JsonKey(name: 'audio_quality')
  String? audioQuality;
  @JsonKey(name: 'is_auto_download')
  bool? isAutoDownload;
  @JsonKey(name: 'is_biometric')
  bool? isBiometric;
  @JsonKey(name: 'is_download_wifi')
  bool? isDownloadWifi;
  @JsonKey(name: 'is_faceid')
  bool? isFaceId;
  @JsonKey(name: 'is_remember')
  bool? isRemember;
  @JsonKey(name: 'is_remind_bedtime')
  bool? isRemindBedtime;
  @JsonKey(name: 'is_set_reminder')
  bool? isSetReminder;

  UserSetting copyWith({
  String? audioQuality,
  bool? isAutoDownload,
  bool? isBiometric,
  bool? isDownloadWifi,
  bool? isFaceId,
  bool? isRemember,
  bool? isRemindBedtime,
  bool? isSetReminder,
})=> UserSetting(
    audioQuality: audioQuality?? this.audioQuality,
      isAutoDownload: isAutoDownload?? this.isAutoDownload,
      isBiometric: isBiometric?? this.isBiometric,
      isDownloadWifi: isDownloadWifi?? this.isDownloadWifi,
      isFaceId: isFaceId?? this.isFaceId,
      isRemember: isRemember?? this.isRemember,
      isRemindBedtime: isRemindBedtime?? this.isRemindBedtime,
      isSetReminder: isSetReminder?? this.isSetReminder,
    );

  factory UserSetting.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserSetting.fromJson(data);
  }

  factory UserSetting.fromJson(Map<String, dynamic> json) =>
      _$UserSettingFromJson(json);

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$UserSettingToJson(this);
}
