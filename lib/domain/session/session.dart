import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable(
  createToJson: true,
)
class Session {
  @JsonKey(includeIfNull: false)
  String? id;
  @JsonKey(name: 'app_use_duration')
  final String? appUseDuration;
  @JsonKey(
    name: 'session_date',
  )
  final int? sessionDate;
  final bool isSessionCompleted;
  final double? rating;

  Session({
    this.id,
    this.appUseDuration,
    this.sessionDate,
    this.isSessionCompleted = false,
    this.rating,
  });

  Session copyWith({
    String? id,
    String? appUseDuration,
    int? sessionDate,
    double? rating,
  }) =>
      Session(
        id: id ?? this.id,
        appUseDuration: appUseDuration ?? this.appUseDuration,
        sessionDate: sessionDate ?? this.sessionDate,
        rating: rating ?? this.rating,
      );

  factory Session.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Session.fromJson(snapshot.id, data);
  }

  Map<String, dynamic> toMap() => {
        'sessionId': id,
        'appUseDuration': appUseDuration,
        "sessionDate": sessionDate?.toString(),
      };

  factory Session.fromJson(String id, Map<String, dynamic> json) =>
      _$SessionFromJson(json)..id = id;

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
