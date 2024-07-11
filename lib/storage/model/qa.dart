import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pb.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pbenum.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/parent.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class Qa extends DbModel {
  static const tableName = 'qa';
  static const createScript = '''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        title VARCHAR(55) NOT NULL,
        ord INTEGER NOT NULL,
        question TEXT NOT NULL,
        qintent VARCHAR(20) NOT NULL,
        dialogue TEXT,
        answer TEXT,
        anstype VARCHAR(20) NOT NULL,
        stage VARCHAR(20) NOT NULL,
        extracted TEXT
      );''';

  String? title;
  int? ord;
  String? question;
  Question_Intent? qintent;
  String? dialogue;
  String? answer;
  Question_AnswerType? anstype;
  Question_Stage? stage;
  String? extracted;

  Qa(
      {super.id,
      this.title,
      this.ord,
      this.question,
      this.qintent,
      this.dialogue,
      this.answer,
      this.anstype,
      this.stage,
      this.extracted});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ord': ord,
      'question': question,
      'qintent': qintent!.name.toUpperCase(),
      'dialogue': dialogue,
      'answer': answer,
      'anstype': anstype!.name.toUpperCase(),
      'stage': stage!.name..toUpperCase(),
      'extracted': extracted
    };
  }

  Qa.fromMap(Map<String, dynamic> map) : super(id: map['id']) {
    title = map['title'];
    ord = map['ord'];
    question = map['question'];
    qintent = Question_Intent.values
        .firstWhere((e) => e.name.toUpperCase() == map['qintent']);
    dialogue = map['dialogue'];
    answer = map['answer'];
    anstype = Question_AnswerType.values
        .firstWhere((e) => e.name.toUpperCase() == map['anstype']);
    stage = Question_Stage.values
        .firstWhere((e) => e.name.toUpperCase() == map['stage']);
    extracted = map['extracted'];
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
      _logger.d('Table `${Qa.tableName}` (re)created');
    });

    db.delete(Qa.tableName);

    for (var qaJson in recs) {
      final qa = Qa.fromMap(qaJson);
      await insert(qa);
    }

    _logger.d('`${Qa.tableName}` table initialization completed');
  }
}
