import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:json_annotation/json_annotation.dart';

part 'previous_searches.g.dart';

@JsonSerializable(includeIfNull: false)
class PreviousSearches {
  String? id;
  final String? name;
  @JsonKey(
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  final DateTime? createdAt;

  PreviousSearches({this.id, this.name, this.createdAt});

  PreviousSearches copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) =>
      PreviousSearches(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  factory PreviousSearches.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return PreviousSearches.fromJson(snapshot.id, data);
  }

  factory PreviousSearches.fromJson(String id, Map<String, dynamic> json) =>
      _$PreviousSearchesFromJson(json)..id = id;

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$PreviousSearchesToJson(this);
}
