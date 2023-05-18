class SessionTime {
  final String sessionId;
  final String totalTime;

  const SessionTime({
    required this.sessionId,
    required this.totalTime,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'totalTime':totalTime,
    };
  }

  // Implement toString to make it easier to see information about
  // each log when using the print statement.
  @override
  String toString() {
    return 'SessionTime{sessionId: $sessionId, totalTime: $totalTime}';
  }
}