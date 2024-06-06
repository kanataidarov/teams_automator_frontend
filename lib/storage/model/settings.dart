import 'package:interview_automator_frontend/storage/db.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class Setting {
  static const tableName = 'settings';
  static const createScript = '''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        value TEXT NOT NULL,
        title TEXT NOT NULL,
        section TEXT NOT NULL,
        type TEXT NOT NULL,
        description TEXT
      );''';

  int? id;
  String? name;
  String? value;
  String? title;
  String? section;
  String? type;
  String? description;

  Setting(
      {this.id,
      this.name,
      this.value,
      this.title,
      this.section,
      this.type,
      this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'title': title,
      'section': section,
      'type': type,
      'description': description
    };
  }

  Setting.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    value = map['value'];
    title = map['title'];
    section = map['section'];
    type = map['type'];
    description = map['description'];
  }

  @override
  String toString() =>
      '${Setting.tableName}(Id=$id,name=`$name`,title=`$title`,section=`$section`,type=`$type`)';
}

class SettingsProvider {
  final _dbHelper = DbHelper.instance;

  SettingsProvider._privateConstructor();
  static final SettingsProvider instance =
      SettingsProvider._privateConstructor();

  Future<int> insert(Setting s) async {
    final db = await _dbHelper.database;
    final id = await db.insert(Setting.tableName, s.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    s.id = id;
    _logger.d('Record $s inserted');
    return id;
  }

  Future<void> update(Setting s) async {
    final db = await _dbHelper.database;
    final count = await db.update(Setting.tableName, s.toMap(),
        where: 'id = ?', whereArgs: [s.id]);
    _logger.d('$count records updated in `${Setting.tableName}`');
  }

  Future<void> delete(Setting s) async {
    final db = await _dbHelper.database;
    final count =
        await db.delete(Setting.tableName, where: 'id = ?', whereArgs: [s.id]);
    _logger.d('$count records deleted in `${Setting.tableName}`');
  }

  Future<void> recreateTable(List<dynamic> recs) async {
    final db = await _dbHelper.database;
    await db.execute('''DROP TABLE IF EXISTS ${Setting.tableName};''');
    db.execute(Setting.createScript).then((_) {
      _logger.d('Table ${Setting.tableName} (re)created');
    });

    db.delete(Setting.tableName);

    for (var stngJson in recs) {
      final stng = Setting.fromMap(stngJson);
      await insert(stng);
    }

    _logger.d('`${Setting.tableName}` table initialization completed');
  }

  Future<Setting> byName(String name) async {
    final db = await _dbHelper.database;
    var res =
        await db.query(Setting.tableName, where: 'name = ?', whereArgs: [name]);
    return Setting.fromMap(res[0]);
  }
}
