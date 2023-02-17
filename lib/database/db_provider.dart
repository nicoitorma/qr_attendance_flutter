import 'package:path/path.dart';
import 'package:qr_attendance/data.classes/attendance.dart';
import 'package:qr_attendance/data.classes/master_list.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // if _database is null, instantiate it
    _database = await initDB();
    return _database!;
  }

  static const tableMasterlist =
      'CREATE TABLE IF NOT EXISTS Masterlist(id INTEGER PRIMARY KEY, filepath TEXT, filename TEXT)';
  static const tableAttendancelist =
      'CREATE TABLE IF NOT EXISTS Attendancelist(id INTEGER PRIMARY KEY, name TEXT, details TEXT, time TEXT)';

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), "core.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(tableMasterlist);
      await db.execute(tableAttendancelist);
    });
  }

  Future<void> insertMasterlistFile(FileMasterList masterList) async {
    final db = await database;
    await db.insert(
      'Masterlist',
      masterList.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> insertAttendance(Attendance attendance) async {
    final db = await database;
    await db.insert(
      'Attendancelist',
      attendance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<List> retrieveMasterlist(String tableName) async {
    final db = await database;
    var maps = await db.query(tableName);

    if (tableName == 'Masterlist') {
      return List.generate(maps.length, (i) {
        return FileMasterList(
          filepath: maps[i]['filepath'].toString(),
          filename: maps[i]['filename'].toString(),
        );
      });
    } else {
      var maps = await _database!.query('Attendancelist');

      return List.generate(maps.length, (i) {
        return Attendance(
            id: maps[i]['id'],
            name: maps[i]['name'].toString(),
            details: maps[i]['details'].toString(),
            time: maps[i]['time'].toString());
      });
    }
  }
}
