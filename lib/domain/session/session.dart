import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/shared/constants/global.dart';
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
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  final DateTime? sessionDate;
  final bool isSessionCompleted;

  Session({
    this.id,
    this.appUseDuration,
    this.sessionDate,
    this.isSessionCompleted=true
});

  Session copyWith({
      String? id,
  String? appUseDuration,
  DateTime? sessionDate,
})=> Session(
    id: id?? this.id,
    appUseDuration: appUseDuration ?? this.appUseDuration,
    sessionDate: sessionDate?? this.sessionDate,
    );

  factory Session.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Session.fromJson(snapshot.id, data);
  }

  Map<String, dynamic> toMap() => {
    'sessionId': id,
    'appUseDuration': appUseDuration,
    "sessionDate": sessionDate?.millisecondsSinceEpoch.toString(),
  };

  factory Session.fromJson(String id, Map<String, dynamic> json) =>
      _$SessionFromJson(json)..id = id;

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
