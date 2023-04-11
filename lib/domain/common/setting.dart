import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable(
  createToJson: true,
)
class DropAndGoSetting {
  String? id;
  String? title;
  String? subtitle;
  List<String>? data;

  DropAndGoSetting({
    this.id,
    this.title,
    this.subtitle,
    this.data,
  });

  factory DropAndGoSetting.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return DropAndGoSetting.fromJson(snapshot.id, data);
  }

  factory DropAndGoSetting.fromJson(String id, Map<String, dynamic> json) =>
      _$DropAndGoSettingFromJson(json)..id = id;

  Map<String, dynamic> toDocument() => toJson();

  Map<String, dynamic> toJson() => _$DropAndGoSettingToJson(this);
}
