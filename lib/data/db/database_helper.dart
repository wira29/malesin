import 'package:malesin/data/models/assignment.dart';
import 'package:malesin/data/models/schedule.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tbAssignment = "tbAssignment";
  static const String _tbSchedule = "tbSchedule";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/malesin.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tbAssignment (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          mapel VARCHAR,
          title VARCHAR,
          desc TEXT,
          status VARCHAR,
          dl DATE
          )''');
        await db.execute('''CREATE TABLE $_tbSchedule (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          day INT,
          title TEXT,
          start TEXT,
          end TEXT
        )''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

// assignment
  Future<List<Map<String, dynamic>>> getAssignments() async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_tbAssignment, orderBy: 'dl');
    return results;
  }

  Future<void> insertAssignment(Assignment newData) async {
    final db = await database;
    await db!.execute(
        '''INSERT INTO $_tbAssignment(mapel, title, desc, status, dl) VALUES(
          "${newData.mapel}","${newData.title}","${newData.desc}", "${newData.status}", "${newData.dl}"
        )''');
  }

  Future<void> deleteAssignment(int id) async {
    final db = await database;
    await db!.delete(_tbAssignment, where: 'id = ?', whereArgs: [id]);
  }
  // end assignment

  // schedule
  Future<List<Map<String, dynamic>>> getListSchedule() async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_tbSchedule, orderBy: 'start');
    return results;
  }

  Future<List<Map<String, dynamic>>> getSchedule(int day) async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_tbSchedule, where: 'day = ?', whereArgs: [day]);
    return results;
  }

  Future<void> insertSchedule(Schedule data) async {
    final db = await database;
    await db!.insert(_tbSchedule, data.toJson());
  }

  Future<void> deleteSchedule(int id) async {
    final db = await database;
    await db!.delete(_tbSchedule, where: 'id = ?', whereArgs: [id]);
  }
  // end schedule
}
