import 'package:interview_automator_frontend/storage/db.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class Settings {
  static const tableName = 'settings';
  static const createScript = '''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        value TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT
      );''';

  int? id;
  String? name;
  String? value;
  String? title;
  String? description;

  Settings({this.id, this.name, this.value, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'value': value,
      'title': title,
      'description': description
    };
  }

  Settings.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    value = map['value'];
    title = map['title'];
    description = map['description'];
  }

  @override
  String toString() =>
      '${Settings.tableName}(Id=$id,name=`$name`,title=`$title`)';
}

class SettingsProvider {
  final _dbHelper = DbHelper.instance;

  SettingsProvider._privateConstructor();
  static final SettingsProvider instance =
      SettingsProvider._privateConstructor();

  Future<int> insert(Settings s) async {
    final db = await _dbHelper.database;
    final id = await db.insert(Settings.tableName, s.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    s.id = id;
    _logger.d('Record $s inserted');
    return id;
  }

  Future<void> update(Settings s) async {
    final db = await _dbHelper.database;
    final count = await db.update(Settings.tableName, s.toMap(),
        where: 'id = ?', whereArgs: [s.id]);
    _logger.d('$count records updated in `${Settings.tableName}`');
  }

  Future<void> delete(Settings s) async {
    final db = await _dbHelper.database;
    final count =
        await db.delete(Settings.tableName, where: 'id = ?', whereArgs: [s.id]);
    _logger.d('$count records deleted in `${Settings.tableName}`');
  }

  Future<void> recreateTable(List<dynamic> recs) async {
    final db = await _dbHelper.database;
    await db.execute('''DROP TABLE IF EXISTS ${Settings.tableName};''');
    db.execute(Settings.createScript).then((_) {
      _logger.d('Table ${Settings.tableName} (re)created');
    });

    db.delete(Settings.tableName);

    for (var stngJson in recs) {
      final stng = Settings.fromMap(stngJson);
      await insert(stng);
    }

    _logger.d('`${Settings.tableName}` table initialization completed');
  }
}
