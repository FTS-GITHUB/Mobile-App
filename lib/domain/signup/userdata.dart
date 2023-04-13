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
  });

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserData.fromJson(snapshot.id, data);
  }

  factory UserData.fromJson(String id, Map<String, dynamic> json) =>
      _$UserDataFromJson(json)..id = id;

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
