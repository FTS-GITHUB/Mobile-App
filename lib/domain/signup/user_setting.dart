import 'package:json_annotation/json_annotation.dart';

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

  String? audioQuality;
  bool? isAutoDownload;
  bool? isBiometric;
  bool? isDownloadWifi;
  bool? isFaceId;
  bool? isRemember;
  bool? isRemindBedtime;
  bool? isSetReminder;
}
