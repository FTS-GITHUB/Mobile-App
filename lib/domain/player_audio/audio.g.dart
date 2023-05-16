// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audio _$AudioFromJson(Map<String, dynamic> json) => Audio(
      artist: json['artist'] as String?,
      audioUrl: json['audio_url'] as String?,
      category: json['category'] == null
          ? null
          : AudioCategory.fromJson(json['category'] as Map<String, dynamic>),
      creator: json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>),
      id: json['id'] as String?,
      title: json['title'] as String?,
      createdAt: dateFromJson(json['created_at'] as Timestamp?),
    );

Map<String, dynamic> _$AudioToJson(Audio instance) => <String, dynamic>{
      'artist': instance.artist,
      'audio_url': instance.audioUrl,
      'category': instance.category?.toJson(),
      'creator': instance.creator?.toJson(),
      'id': instance.id,
      'title': instance.title,
      'created_at': dateToJson(instance.createdAt),
    };

AudioCategory _$AudioCategoryFromJson(Map<String, dynamic> json) =>
    AudioCategory(
      id: json['id'] as String?,
      imageUrl: json['audio_url'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AudioCategoryToJson(AudioCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'audio_url': instance.imageUrl,
      'name': instance.name,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
