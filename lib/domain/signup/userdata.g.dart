// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as String?,
      fullName: json['full_name'] as String?,
      gender: json['gender'] as String?,
      ageGroup: json['age_group'] as String?,
      achievement: json['achievement'] as String?,
      level: json['level'] as String?,
      profilePicUrl: json['profile_pic_url'] as String?,
      email: json['email'] as String?,
      phoneNo: json['phoneNo'] as String?,
      country: json['country'] as String?,
      dateOfBirth: dateFromJson(json['date_of_birth'] as Timestamp?),
      createdAt: dateFromJson(json['created_at'] as Timestamp?),
      isDeleted: json['is_deleted'] as bool? ?? false,
      signInMethod: json['sign_in_method'] as String?,
      likedCategories: (json['liked_categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      currentStreak: json['current_streak'] as int? ?? 0,
      longestStreak: json['longest_streak'] as int? ?? 0,
      sessionsListened: json['sessions_listened'] as int? ?? 0,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('full_name', instance.fullName);
  writeNotNull('gender', instance.gender);
  writeNotNull('age_group', instance.ageGroup);
  writeNotNull('achievement', instance.achievement);
  writeNotNull('level', instance.level);
  writeNotNull('profile_pic_url', instance.profilePicUrl);
  writeNotNull('email', instance.email);
  writeNotNull('phoneNo', instance.phoneNo);
  writeNotNull('country', instance.country);
  writeNotNull('date_of_birth', dateToJson(instance.dateOfBirth));
  writeNotNull('created_at', dateToJson(instance.createdAt));
  val['is_deleted'] = instance.isDeleted;
  writeNotNull('liked_categories', instance.likedCategories);
  writeNotNull('sign_in_method', instance.signInMethod);
  writeNotNull('current_streak', instance.currentStreak);
  writeNotNull('longest_streak', instance.longestStreak);
  writeNotNull('sessions_listened', instance.sessionsListened);
  return val;
}
