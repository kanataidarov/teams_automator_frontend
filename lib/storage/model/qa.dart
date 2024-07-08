import 'package:interview_automator_frontend/storage/db.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class Qa {
  static const tableName = 'qa';
  static const createScript = '''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        title VARCHAR(55) NOT NULL,
        ord INTEGER NOT NULL,
        question TEXT NOT NULL,
        qparam TEXT,
        answer TEXT,
        anstype INTEGER NOT NULL,
        stage VARCHAR(20) NOT NULL
      );''';

  int? id;
  String? title;
  int? ord;
  String? question;
  String? qparam;
  String? answer;
  int? anstype;
  String? stage;

  Qa(
      {this.id,
      this.title,
      this.ord,
      this.question,
      this.qparam,
      this.answer,
      this.anstype,
      this.stage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ord': ord,
      'question': question,
      'qparam': qparam,
      'answer': answer,
      'anstype': anstype,
      'stage': stage
    };
  }

  Qa.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    ord = map['ord'];
    question = map['question'];
    qparam = map['qparam'];
    answer = map['answer'];
    anstype = map['anstype'];
    stage = map['stage'];
  }

  @override
  String toString() => '${Qa.tableName}(Id=$id,title=`$title`,order=$ord)';
}

class QaProvider {
  final _dbHelper = DbHelper.instance;

  QaProvider._privateConstructor();
  static final QaProvider instance = QaProvider._privateConstructor();

  Future<int> insert(Qa qa) async {
    final db = await _dbHelper.database;
    final id = await db.insert(Qa.tableName, qa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    qa.id = id;
    _logger.d('Record $qa inserted');
    return id;
  }

  Future<void> update(Qa qa) async {
    final db = await _dbHelper.database;
    final count = await db
        .update(Qa.tableName, qa.toMap(), where: 'id = ?', whereArgs: [qa.id]);
    _logger.d('$count records updated in `${Qa.tableName}`');
  }

  Future<void> delete(Qa qa) async {
    final db = await _dbHelper.database;
    final count =
        await db.delete(Qa.tableName, where: 'id = ?', whereArgs: [qa.id]);
    _logger.d('$count records deleted in `${Qa.tableName}`');
  }

  Future<void> recreateTable(List<dynamic> recs) async {
    final db = await _dbHelper.database;
    await db.execute('''DROP TABLE IF EXISTS ${Qa.tableName};''');
    db.execute(Qa.createScript).then((_) {
      _logger.d('Table ${Qa.tableName} (re)created');
    });

    db.delete(Qa.tableName);

    for (var qaJson in recs) {
      final qa = Qa.fromMap(qaJson);
      await insert(qa);
    }

    _logger.d('`${Qa.tableName}` table initialization completed');
  }
}
