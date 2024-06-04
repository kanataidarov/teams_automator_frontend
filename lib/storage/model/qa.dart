import 'package:interview_automator_frontend/storage/db.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class Qa {
  static const tableName = 'qa';
  static const createScript = '''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        ord INTEGER NOT NULL,
        question TEXT NOT NULL,
        answer TEXT,
        qparam TEXT
      );''';

  int? id;
  String? title;
  int? ord;
  String? question;
  String? answer;
  String? qparam;

  Qa({this.id, this.title, this.ord, this.question, this.answer, this.qparam});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ord': ord,
      'question': question,
      'answer': answer,
      'qparam': qparam
    };
  }

  Qa.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    ord = map['ord'];
    question = map['question'];
    answer = map['answer'];
    qparam = map['qparam'];
  }

  static List<String> questions() {
    return [
      """You have given part of interview session. Interview were held for middle java software developer position. Interview was in Russian.      
\nHere is text transcription of given interview part:                                                                                             
\n{}                                                                                                                                              
\nExtract all questions asked by interviewer. """,
      """Extract answer to questions just extracted by you from given transcription part. Generate JSON containing questions and answers.          
\nJSON structure should be following: { "interview_session": [ "question": "", "answer": "", ... ] } """
    ];
  }
}

class QaProvider {
  final _dbHelper = DbHelper.instance;

  QaProvider._privateConstructor();
  static final QaProvider instance = QaProvider._privateConstructor();

  Future<void> initQa() async {
    final db = await _dbHelper.database;

    await db.execute('''DROP TABLE IF EXISTS ${Qa.tableName};''');
    db.execute(Qa.createScript).then((_) {
      _logger.d('Table ${Qa.tableName} created');
    });

    db.delete(Qa.tableName);
    var qas = Qa.questions();
    for (var i = 0; i < qas.length; i++) {
      final qa = Qa(title: 'QA $i', ord: i, question: qas[i]);
      await insert(qa);
    }

    _logger.d('`${Qa.tableName}` table initialization completed');
  }

  Future<void> insert(Qa qa) async {
    final db = await _dbHelper.database;
    final id = await db.insert(Qa.tableName, qa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _logger.d('Record with $id inserted to `${Qa.tableName}`');
  }

  Future<void> update(Qa qa) async {
    final db = await _dbHelper.database;
    final count = await db
        .update(Qa.tableName, qa.toMap(), where: 'id = ?', whereArgs: [qa.id]);
    _logger.d('$count records updated in `${Qa.tableName}`');
  }
}
