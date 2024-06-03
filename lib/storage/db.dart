import 'model/qa.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class DbHelper {
  static const _dbName = 'interview_automator.db';
  static const _dbVer = 1;

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path =
        join((await getApplicationDocumentsDirectory()).path, _dbName);

    var db = await openDatabase(path, version: _dbVer, onCreate: _onCreate);

    _logger.d('Database opened at ${db.path}');
    return db;
  }

  Future _onCreate(Database db, int version) async {
    db.execute(Qa.script).then((_) {
      _logger.d('Table ${Qa.tableName} created');
    });
  }

  Future<void> initQa() async {
    final db = await database;
    db.delete(Qa.tableName);
    var qas = Qa.questions();
    for (var i = 0; i < qas.length; i++) {
      final qa = Qa(title: 'Question $i', ord: i, question: qas[i]);
      await insert(db, qa);
    }
  }

  Future<void> insert(Database db, Qa qa) async {
    await db.insert(Qa.tableName, qa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
