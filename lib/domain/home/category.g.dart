// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      createdAt: dateFromJson(json['created_at'] as Timestamp?),
      imageUrl: json['image_url'] as String?,
      isDeleted: json['is_deleted'] as bool?,
      isRecommended: json['is_recommended'] as bool?,
      name: json['name'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'created_at': dateToJson(instance.createdAt),
      'image_url': instance.imageUrl,
      'is_deleted': instance.isDeleted,
      'is_recommended': instance.isRecommended,
      'name': instance.name,
      'id': instance.id,
    };
