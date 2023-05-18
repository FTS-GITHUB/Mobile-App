import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/domain/session/session_time.dart';
import 'package:sqflite/sqflite.dart';

const String activeSession = 'ActiveSession';

class LocalDatabaseService {
  LocalDatabaseService._constructor();

  static final LocalDatabaseService instance = LocalDatabaseService._constructor();
  factory LocalDatabaseService() => instance;
  late Database database;
  Future<void> initialize() async {

    database = await openDatabase('current_session.db', version: 1);

    await database.execute(
      'create table if not exists $activeSession (id INTEGER PRIMARY KEY, sessionId TEXT,userId TEXT, appUseDuration TEXT, sessionDate INTEGER)',
    );
  }

  Future<void> recordSession({required Session session}) async {
    await database.insert(
      activeSession,
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Session>> getSessionsList() async {
    // Get a reference to the database.

    // Query the table for all The ActiveWalk.
    final List<Map<String, dynamic>> maps = await database.query(activeSession);

    // Convert the List<Map<String, dynamic> into a List<ActiveWalk>.
    return List.generate(maps.length, (i) {
      return Session(
       id: maps[i]['sessionId'],
        appUseDuration: maps[i]['appUseDuration'],
        sessionDate: maps[i]['sessionDate'],
      );
    });
  }

  Future<int> delete(String id) async {
    return await database.delete(activeSession, where: 'sessionId = ?', whereArgs: [id]);
  }
}