import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(
  createToJson: true,
)
class Category{
  Category({
    this.createdAt,
    this.imageUrl,
    this.isDeleted,
    this.isRecommended,
    this.name,
});

  Category copyWith({
  DateTime? createdAt,
  String? imageUrl,
  bool? isDeleted,
  bool? isRecommended,
  String? name,
})=> Category(
    createdAt: createdAt?? this.createdAt,
    imageUrl: imageUrl?? this.imageUrl,
    isDeleted: isDeleted?? this.isDeleted,
    isRecommended: isRecommended?? this.isRecommended,
    name: name?? this.name,
  );

  @JsonKey(
    name: 'created_at',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  final DateTime? createdAt;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'is_deleted')
  final bool? isDeleted;
  @JsonKey(name: 'is_recommended')
  final bool? isRecommended;
  final String? name;
  String? id;

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Category.fromJson(snapshot.id, data);
  }

  factory Category.fromJson(String id, Map<String, dynamic> json) =>
      _$CategoryFromJson(json)..id = id;

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
