import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: true,
)
class Audio {
  Audio({
    this.artist,
    this.audioUrl,
    this.imageUrl,
    this.categories,
    this.creator,
    this.id,
    this.title,
    this.createdAt,
  });

  final String? artist;
  @JsonKey(name: 'audio_url')
  final String? audioUrl;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<AudioCategory>? categories;
  final Creator? creator;
  String? id;
  final String? title;
  @JsonKey(
    name: 'created_at',
    fromJson: dateFromJson,
    toJson: dateToJson,
  )
  final DateTime? createdAt;

  factory Audio.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Audio.fromJson(snapshot.id, data);
  }

  factory Audio.fromJson(String id, Map<String, dynamic> json) =>
      _$AudioFromJson(json)..id = id;

  Map<String, dynamic> toDocument() => toJson();

  Map<String, dynamic> toJson() => _$AudioToJson(this);
}

@JsonSerializable()
class AudioCategory {
  AudioCategory({
    this.id,
    this.imageUrl,
    this.name,
  });

  final String? id;
  @JsonKey(name: 'audio_url')
  final String? imageUrl;
  final String? name;

  factory AudioCategory.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return AudioCategory.fromJson(data);
  }

  factory AudioCategory.fromJson(Map<String, dynamic> json) =>
      _$AudioCategoryFromJson(json);

  Map<String, dynamic> toDocument() => toJson();

  Map<String, dynamic> toJson() => _$AudioCategoryToJson(this);
}

@JsonSerializable()
class Creator {
  Creator({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  factory Creator.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Creator.fromJson(data);
  }

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);

  Map<String, dynamic> toDocument() => toJson();

  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}
