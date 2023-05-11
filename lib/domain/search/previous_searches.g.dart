// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_searches.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviousSearches _$PreviousSearchesFromJson(Map<String, dynamic> json) =>
    PreviousSearches(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PreviousSearchesToJson(PreviousSearches instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}
