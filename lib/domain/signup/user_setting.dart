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
    this.isBiometric = true,
    this.isDownloadWifi = true,
    this.isFaceId = true,
    this.isRemember = true,
    this.isRemindBedtime = true,
    this.isSetReminder = true,
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

  factory UserSetting.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserSetting.fromJson(snapshot.id, data);
  }

  factory UserSetting.fromJson(String id, Map<String, dynamic> json) =>
      _$UserSettingFromJson(json);

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$UserSettingToJson(this);
}
