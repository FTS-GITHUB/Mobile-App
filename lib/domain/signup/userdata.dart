import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userdata.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class UserData {
  String? id;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? gender;
  @JsonKey(name: 'age_group')
  final String? ageGroup;
  final String? achievement;
  final String? level;
  @JsonKey(name: 'profile_pic_url')
  final String? profilePicUrl;
  final String? email;
  final String? phoneNo;
  final String? country;
  @JsonKey(
    name: 'date_of_birth',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  final DateTime? dateOfBirth;
  @JsonKey(
    name: 'created_at',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  final DateTime? createdAt;
  @JsonKey(includeToJson: false, includeFromJson: false)
  File? file;

  UserData({
    this.id,
    this.fullName,
    this.gender,
    this.ageGroup,
    this.achievement,
    this.level,
    this.profilePicUrl,
    this.email,
    this.phoneNo,
    this.country,
    this.dateOfBirth,
    this.file,
    this.createdAt,
  });

  UserData copyWith({
    String? id,
    String? fullName,
    String? gender,
    String? ageGroup,
    String? achievement,
    String? level,
    String? profilePicUrl,
    String? email,
    String? phoneNo,
    String? country,
    DateTime? dateOfBirth,
    DateTime? createdAt,
  }) =>
      UserData(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        gender: gender ?? this.gender,
        ageGroup: ageGroup ?? this.ageGroup,
        achievement: achievement ?? this.achievement,
        level: level ?? this.level,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        country: country ?? this.country,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserData.fromJson(data);
  }

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
