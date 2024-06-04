import 'package:logger/logger.dart' show Level, Logger;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class DbHelper {
  static const _dbName = 'interview_automator.db';
  static const _dbVer = 3;

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    var path = join((await getApplicationDocumentsDirectory()).path, _dbName);

    var db = await openDatabase(path, version: _dbVer);

    _logger.d('Database opened at ${db.path}');
    return db;
  }

  Future close() async => _database!.close();
}
